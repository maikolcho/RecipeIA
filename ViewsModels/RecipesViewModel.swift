//
//  RecetasViewModel.swift
//
//
//
//  NombreDelArchivo.swift
//  RecipeIA
//
//  Created by Nelson Ariel Villalba Vergara on 2025-03-17.
//  Copyright © 2025 Nelson Ariel Villalba Vergara. Todos los derechos reservados.

import Foundation

@MainActor
class RecipesViewModel: ObservableObject {
    @Published var userRecipes: [Recipe] = []
    @Published var favoriteRecipes: [Recipe] = []
    @Published var recipes: [Recipe] = []
    @Published var categories: [String] = []
    @Published var isLoading: Bool = false
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""

    private let userRecipesKey = "userRecipes"
    private let favoritesKey = "favoriteRecipes"
    private let categoriesKey = "userCategories"

    init() {
        print("✅ RecipesViewModel se inicializó correctamente.")
        loadUserRecipes()
        loadFavorites()
        loadCategories()
    }

    // MARK: - Categorías

    func agregarCategoria(_ nombre: String) {
        let nueva = nombre.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !nueva.isEmpty else { return }
        if !categories.contains(nueva) {
            categories.append(nueva)
            saveCategories()
        }
    }

    func eliminarCategoria(_ nombre: String) {
        categories.removeAll { $0 == nombre }

        for i in 0..<userRecipes.count {
            if userRecipes[i].categoria.rawValue == nombre {
                userRecipes[i].categoria = .sinCategoria
            }
        }

        saveCategories()
        saveUserRecipes()
    }

    func renombrarCategoria(nombreActual: String, nuevoNombre: String) {
        let nuevo = nuevoNombre.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !nuevo.isEmpty, let index = categories.firstIndex(of: nombreActual) else { return }

        categories[index] = nuevo

        for i in 0..<userRecipes.count {
            if userRecipes[i].categoria.rawValue == nombreActual {
                userRecipes[i].categoria = Categoria.from(rawValue: nuevo)
            }
        }

        saveCategories()
        saveUserRecipes()
    }

    private func saveCategories() {
        UserDefaults.standard.set(categories, forKey: categoriesKey)
    }

    private func loadCategories() {
        let defaultCategories = ["Desayuno", "Sopa", "Ensalada", "Postre", "Carne", "Mariscos", "Sin categoría"]

        if let saved = UserDefaults.standard.array(forKey: categoriesKey) as? [String] {
            // Combina las categorías guardadas con las predeterminadas, sin duplicados
            self.categories = (saved + defaultCategories).uniqued()
        } else {
            self.categories = defaultCategories
        }
    }


    // MARK: - Recetas

    func agregarReceta(_ recipe: Recipe) {
        if !userRecipes.contains(where: { $0.nombre.lowercased() == recipe.nombre.lowercased() }) {
            userRecipes.append(recipe)
            saveUserRecipes()
        } else {
            print("⚠️ La receta ya existe. No se agregó.")
        }
    }

    func actualizarReceta(_ recetaActualizada: Recipe) {
        if let index = userRecipes.firstIndex(where: { $0.id == recetaActualizada.id }) {
            userRecipes[index] = recetaActualizada
            saveUserRecipes()
        }
    }

    func eliminarReceta(_ recipe: Recipe) {
        userRecipes.removeAll { $0.id == recipe.id }
        saveUserRecipes()
    }

    func eliminarRecetas(categoria: Categoria) {
        userRecipes.removeAll { $0.categoria == categoria }
        saveUserRecipes()
    }

    private func saveUserRecipes() {
        Task { @MainActor in
            let uniqueRecipes = userRecipes.uniqued()
            if let encoded = try? JSONEncoder().encode(uniqueRecipes) {
                UserDefaults.standard.set(encoded, forKey: userRecipesKey)
            }
        }
    }

    private func loadUserRecipes() {
        Task { @MainActor in
            if let savedData = UserDefaults.standard.data(forKey: userRecipesKey),
               let savedRecipes = try? JSONDecoder().decode([Recipe].self, from: savedData) {
                self.userRecipes = savedRecipes.uniqued()
            }
        }
    }

    // MARK: - Favoritos

    func toggleFavorite(recipe: Recipe) {
        if let index = favoriteRecipes.firstIndex(where: { $0.id == recipe.id }) {
            favoriteRecipes.remove(at: index)
        } else {
            favoriteRecipes.append(recipe)
        }
        saveFavorites()
    }

    func esRecetaFavorita(_ recipe: Recipe) -> Bool {
        return favoriteRecipes.contains(where: { $0.id == recipe.id })
    }

    private func saveFavorites() {
        Task { @MainActor in
            let uniqueFavorites = favoriteRecipes.uniqued()
            if let encoded = try? JSONEncoder().encode(uniqueFavorites) {
                UserDefaults.standard.set(encoded, forKey: favoritesKey)
            }
        }
    }

    private func loadFavorites() {
        Task { @MainActor in
            if let savedData = UserDefaults.standard.data(forKey: favoritesKey),
               let savedFavorites = try? JSONDecoder().decode([Recipe].self, from: savedData) {
                self.favoriteRecipes = savedFavorites.uniqued()
            }
        }
    }

    // MARK: - Buscar Recetas

    func buscarRecetas(con ingredientes: [String]) async {
        guard !ingredientes.isEmpty else {
            mostrarError(mensaje: "Para que la búsqueda funcione será necesario insertar un ingrediente o varios separados por comas")
            return
        }

        isLoading = true
        showError = false

        do {
            let apiRecipes: [Recipe]
            do {
                // 1) Recetas generadas con IA (Gemini)
                apiRecipes = try await GeminiAPI().generarRecetas(ingredientes: ingredientes)
            } catch let geminiError {
                // 2) Respaldo: búsqueda de alimentos en Nutritionix
                print("⚠️ Gemini no disponible (\(geminiError.localizedDescription)). Usando Nutritionix.")
                let fetchedRecipes: [Recipe]
                do {
                    fetchedRecipes = try await fetchRecipesFromAPI(ingredientes: ingredientes)
                } catch {
                    throw geminiError  // el motivo útil es el de la IA, no el del respaldo
                }
                apiRecipes = fetchedRecipes.map { apiRecipe in
                    Recipe(
                        id: UUID(),
                        nombre: apiRecipe.nombre,
                        image: apiRecipe.image,
                        descripcion: "Alimento relacionado con tu búsqueda (Nutritionix).",
                        ingredientes: "Ingredientes no disponibles.",
                        pasos: "Pasos no disponibles.",
                        categoria: .sinCategoria,
                        datePublished: apiRecipe.datePublished,
                        url: "https://www.nutritionix.com"
                    )
                }
            }

            let userFilteredRecipes = userRecipes.filter { recipe in
                ingredientes.contains { ingrediente in
                    recipe.ingredientes.lowercased().contains(ingrediente.lowercased())
                }
            }

            self.recipes = apiRecipes + userFilteredRecipes

            if self.recipes.isEmpty {
                mostrarError(mensaje: "No se han encontrado recetas para el ingrediente que ha insertado")
            }

            isLoading = false
        } catch {
            mostrarError(mensaje: (error as? LocalizedError)?.errorDescription ?? "Error al obtener recetas de la API.")
        }
    }

    private func fetchRecipesFromAPI(ingredientes: [String]) async throws -> [Recipe] {
        let api = NutritionixAPI()
        var allRecipes: [Recipe] = []
        for ingrediente in ingredientes {
            let recipes = try await api.buscarRecetas(ingrediente: ingrediente)
            allRecipes.append(contentsOf: recipes)
        }
        return allRecipes.uniqued()
    }

    private func mostrarError(mensaje: String) {
        Task { @MainActor in
            self.errorMessage = mensaje
            self.showError = true
            self.isLoading = false
        }
    }
}

// MARK: - Eliminar duplicados
extension Array where Element: Hashable {
    func uniqued() -> [Element] {
        var seen = Set<Element>()
        return filter { seen.insert($0).inserted }
    }
}
