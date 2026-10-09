//
//  File.swift
//  RecipeIA
//
//  Created by Maik on 9/1/25.
//
//
//  NombreDelArchivo.swift
//  RecipeIA
//
//  Created by Nelson Ariel Villalba Vergara on 2025-03-17.
//  Copyright © 2025 Nelson Ariel Villalba Vergara. Todos los derechos reservados.
//

import Foundation

struct RecipesResponse: Codable {
    let recipes: [Recipe]  // ✅ Cambiado a 'recipes' para coincidir con NutritionixAPI.swift

    enum CodingKeys: String, CodingKey {
        case recipes
    }
}
