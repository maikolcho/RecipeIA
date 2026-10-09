
//  NutritionixAPI.swift
//  Recipe
//
//  NombreDelArchivo.swift
//  RecipeIA
//
//  Created by Nelson Ariel Villalba Vergara on 2025-03-17.
//  Copyright © 2025 Nelson Ariel Villalba Vergara. Todos los derechos reservados.
//



import Foundation

class NutritionixAPI {
    private let apiKey = Secrets.nutritionixApiKey
    private let appId = Secrets.nutritionixAppId
    private let baseURL = "https://trackapi.nutritionix.com/v2/search/instant"

    enum NutritionixError: Error {
        case emptyIngredient
        case invalidResponse
        case decodingError
    }

    /// 🔍 **Buscar recetas en Nutritionix**
    func buscarRecetas(ingrediente: String) async throws -> [Recipe] {
        guard !ingrediente.isEmpty else {
            throw NutritionixError.emptyIngredient
        }

        guard let encodedIngrediente = ingrediente.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "\(baseURL)?query=\(encodedIngrediente)") else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(appId, forHTTPHeaderField: "x-app-id")
        request.setValue(apiKey, forHTTPHeaderField: "x-app-key")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            let (data, response) = try await URLSession.shared.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw NutritionixError.invalidResponse
            }

            let result = try JSONDecoder().decode(NutritionixResponse.self, from: data)

            print("✅ Respuesta JSON correcta:", result)

            return result.common.map { item in
                Recipe(
                    nombre: item.food_name.capitalized,
                    image: item.photo.thumb ?? "https://via.placeholder.com/150",
                    descripcion: "Receta basada en \(ingrediente).",
                    ingredientes: ingrediente,
                    pasos: "1. Preparar ingredientes.\n2. Cocinar al gusto.",
                    categoria: .desayuno,
                    datePublished: ISO8601DateFormatter().string(from: Date()),
                    url: "https://www.nutritionix.com"
                )
            }
        } catch {
            print("❌ Error en la API:", error.localizedDescription)
            throw NutritionixError.decodingError
        }
    }
}
