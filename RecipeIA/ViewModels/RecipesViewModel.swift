//
//  RecetasViewModel.swift
//
//
//
//
import Foundation
import SwiftUI

class RecipesViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var isLoading: Bool = false
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""

    private let baseURL = "https://trackapi.nutritionix.com/v2/search/instant"
    private let appId = Secrets.nutritionixAppId
    private let apiKey = Secrets.nutritionixApiKey
    private let savedRecipesKey = "savedRecipes"
    private let favoritesKey = "favoriteRecipes"

    init() {
        loadRecipes()
    }

    /// 🔹 **Buscar recetas en la API de Nutritionix**
    func buscarRecetas(con ingredientes: [String]) {
        isLoading = true
        showError = false
        recipes = []

        let query = ingredientes.joined(separator: " ")
        guard let url = URL(string: "\(baseURL)?query=\(query)") else {
            mostrarError(mensaje: "La URL es inválida.")
            return
        }

        var request = URLRequest(url: url)
        request.addValue(appId, forHTTPHeaderField: "x-app-id")
        request.addValue(apiKey, forHTTPHeaderField: "x-app-key")
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let self = self else { return }

            if let error = error {
                DispatchQueue.main.async {
                    self.mostrarError(mensaje: "Error de red: \(error.localizedDescription)")
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    self.mostrarError(mensaje: "No se recibieron datos del servidor.")
                }
                return
            }

            do {
                let response = try JSONDecoder().decode(RecipesResponse.self, from: data)
                DispatchQueue.main.async {
                    self.recipes = response.common.map { apiRecipe in
                        Recipe(
                            nombre: apiRecipe.food_name.capitalized,
                            image: apiRecipe.photo?.thumb ?? "https://via.placeholder.com/150",
                            descripcion: "Receta basada en \(apiRecipe.food_name).",
                            ingredientes: "Ingredientes no especificados",
                            pasos: "Pasos no especificados",
                            categoria: .api,
                            datePublished: ISO8601DateFormatter().string(from: Date()),
                            url: "https://www.nutritionix.com"
                        )
                    }
                    self.isLoading = false
                }
            } catch {
                DispatchQueue.main.async {
                    self.mostrarError(mensaje: "Error al decodificar los datos: \(error.localizedDescription)")
                }
            }
        }.resume()
    }

    /// 🔹 **Mostrar errores**
    private func mostrarError(mensaje: String) {
        DispatchQueue.main.async {
            self.errorMessage = mensaje
            self.showError = true
            self.isLoading = false
        }
    }

    /// 🔹 **Agregar una receta manualmente**
    func addRecipe(recipe: Recipe) {
        recipes.append(recipe)
        saveRecipes()
    }

    /// 🔹 **Alternar estado de favorito**
    func toggleFavorite(recipe: Recipe) {
        if let index = recipes.firstIndex(where: { $0.id == recipe.id }) {
            recipes[index].isFavorite.toggle()
            saveFavorites()
        }
    }

    /// 🔹 **Guardar recetas en UserDefaults**
    private func saveRecipes() {
        if let encoded = try? JSONEncoder().encode(recipes) {
            UserDefaults.standard.set(encoded, forKey: savedRecipesKey)
        }
    }

    /// 🔹 **Cargar recetas guardadas**
    func loadRecipes() {
        if let savedData = UserDefaults.standard.data(forKey: savedRecipesKey),
           let savedRecipes = try? JSONDecoder().decode([Recipe].self, from: savedData) {
            recipes = savedRecipes
        }
    }

    /// 🔹 **Guardar recetas favoritas**
    func saveFavorites() {
        let favorites = recipes.filter { $0.isFavorite }
        if let encoded = try? JSONEncoder().encode(favorites) {
            UserDefaults.standard.set(encoded, forKey: favoritesKey)
        }
    }

    /// 🔹 **Cargar recetas favoritas**
    func loadFavorites() -> [Recipe] {
        if let savedData = UserDefaults.standard.data(forKey: favoritesKey),
           let savedFavorites = try? JSONDecoder().decode([Recipe].self, from: savedData) {
            return savedFavorites
        }
        return []
    }

    /// 🔹 **Verificar si una receta está en favoritos**
    func isRecipeFavorite(_ nombre: String) -> Bool {
        return loadFavorites().contains { $0.nombre == nombre }
    }
}
