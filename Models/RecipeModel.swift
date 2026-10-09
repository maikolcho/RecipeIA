//
//  RecipeModel.swift
//
//
//  NombreDelArchivo.swift
//  RecipeIA
//
//  Created by Nelson Ariel Villalba Vergara on 2025-03-17.
//  Copyright © 2025 Nelson Ariel Villalba Vergara. Todos los derechos reservados.
//

import Foundation

/// Enum de categorías de recetas en la aplicación
enum Categoria: String, CaseIterable, Identifiable, Codable {
    var id: String { self.rawValue }

    case desayuno = "Desayuno"
    case sopa = "Sopa"
    case ensalada = "Ensalada"
    case postre = "Postre"
    case carne = "Carne"
    case mariscos = "Mariscos"
    case sinCategoria = "Sin categoría" // Para recetas sin una categoría definida
    
    /// Mapea categorías desconocidas a un caso predeterminado
    static func from(rawValue: String) -> Categoria {
        return Categoria(rawValue: rawValue) ?? .sinCategoria
    }
}

/// Modelo principal de receta
struct Recipe: Identifiable, Codable, Hashable {
    let id: UUID
    var nombre: String
    var image: String
    var descripcion: String
    var ingredientes: String
    var pasos: String
    var categoria: Categoria
    var datePublished: String
    var url: String
    var isFavorite: Bool

    // Evitar duplicados correctamente
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: Recipe, rhs: Recipe) -> Bool {
        return lhs.id == rhs.id
    }

    // Constructor con valores predeterminados
    init(
        id: UUID = UUID(),
        nombre: String,
        image: String,
        descripcion: String,
        ingredientes: String,
        pasos: String,
        categoria: Categoria,
        datePublished: String,
        url: String,
        isFavorite: Bool = false
    ) {
        self.id = id
        self.nombre = nombre
        self.image = image
        self.descripcion = descripcion
        self.ingredientes = ingredientes
        self.pasos = pasos
        self.categoria = categoria
        self.datePublished = datePublished
        self.url = url
        self.isFavorite = isFavorite
    }
}
