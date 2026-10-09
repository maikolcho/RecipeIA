//
//  File.swift
//  RecipeIA
//
//  Created by Maik on 9/1/25.
//
import Foundation

/// 📌 Representa la respuesta de la API con una lista de recetas obtenidas
struct RecipesResponse: Codable {
    let common: [RecipeAPI] // Lista de recetas obtenidas
}

/// 📌 Representa cada receta obtenida de la API de Nutritionix
struct RecipeAPI: Codable, Identifiable {
    let id: UUID = UUID() // ID único para cada receta
    let food_name: String // Nombre del alimento
    let serving_qty: Int? // Cantidad de porción
    let serving_unit: String? // Unidad de medida
    let calories: Double? // Cantidad de calorías
    let photo: RecipePhoto? // Imagen del alimento

    /// 🔹 Mapeo de claves JSON
    enum CodingKeys: String, CodingKey {
        case food_name
        case serving_qty
        case serving_unit
        case calories
        case photo
    }
}

/// 📌 Representa la imagen de la receta obtenida de la API.
struct RecipePhoto: Codable {
    let thumb: String // URL de la imagen
}
