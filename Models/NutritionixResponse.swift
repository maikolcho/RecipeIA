//
//  NutritionixResponse.swift
//  RecipeIA
//
//  Created by Maik on 19/2/25.
//
//
//  NombreDelArchivo.swift
//  RecipeIA
//
//  Created by Nelson Ariel Villalba Vergara on 2025-03-17.
//  Copyright © 2025 Nelson Ariel Villalba Vergara. Todos los derechos reservados.
//


import Foundation

/// Estructura para decodificar la respuesta de la API de Nutritionix
struct NutritionixResponse: Codable {
    let common: [ComidaComun]  // 🔹 Aquí se almacenan las comidas genéricas
    let branded: [ComidaMarca]?  // 🔹 Opcional, porque puede no haber resultados de marcas
}

/// Modelo para comidas genéricas (common)
struct ComidaComun: Codable {
    let food_name: String
    let photo: ComidaFoto
}

/// Modelo para productos de marcas (branded)
struct ComidaMarca: Codable {
    let food_name: String
    let brand_name: String
    let photo: ComidaFoto
}

/// Modelo para las imágenes de los alimentos
struct ComidaFoto: Codable {
    let thumb: String?  // 🔹 Puede ser `null`, por eso es opcional
}
