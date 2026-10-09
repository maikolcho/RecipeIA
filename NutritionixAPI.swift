//
//  NutritionixAPI.swift
//  Recipe
//
//  Created by Maik on 27/11/24.
//import Foundation
import Foundation

// Modelo para la respuesta de la API Nutritionix
struct NutritionixResponse: Codable {
    let common: [ComidaComun]
}

struct ComidaComun: Codable {
    let foodName: String
    let photo: Photo

    enum CodingKeys: String, CodingKey {
        case foodName = "food_name"
        case photo
    }
}

struct Photo: Codable {
    let thumb: String
}

// Clase para consumir la API de Nutritionix
class NutritionixAPI {
    private let apiKey = Secrets.nutritionixApiKey
    private let appId = Secrets.nutritionixAppId
   

    func buscarRecetas(ingrediente: String, completion: @escaping (Result<[Recipe], Error>) -> Void) {
        guard let encodedIngrediente = ingrediente.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            completion(.failure(NSError(domain: "Encoding Error", code: 0, userInfo: [NSLocalizedDescriptionKey: "No se pudo codificar el ingrediente."])))
            return
        }

        let urlString = "https://trackapi.nutritionix.com/v2/search/instant?query=\(encodedIngrediente)"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: [NSLocalizedDescriptionKey: "La URL es inválida."])))
            return
        }

        var request = URLRequest(url: url)
        request.setValue(appId, forHTTPHeaderField: "x-app-id")
        request.setValue(apiKey, forHTTPHeaderField: "x-app-key")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No Data", code: 0, userInfo: [NSLocalizedDescriptionKey: "No se recibieron datos de la API."])))
                return
            }

            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(NutritionixResponse.self, from: data)

                let recipes = result.common.map { item in
                    Recipe(
                        nombre: item.foodName.capitalized,
                        image: item.photo.thumb,
                        descripcion: "Receta basada en \(ingrediente).",
                        ingredientes: ingrediente,
                        pasos: "1. Preparar los ingredientes.\n2. Cocinar según preferencia.",
                        categoria: .api,
                        datePublished: ISO8601DateFormatter().string(from: Date()),
                        url: "https://www.nutritionix.com"
                    )
                }

                completion(.success(recipes))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
