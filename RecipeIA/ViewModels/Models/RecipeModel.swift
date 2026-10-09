//
//  RecipeModel.swift
//
//
//
//

//
import Foundation

/// 📌 Enum de categorías de recetas en la aplicación
enum Categoria: String, CaseIterable, Identifiable, Codable {
    var id: String { self.rawValue }
    
    case desayuno = "Desayuno"
    case sopa = "Sopa"
    case ensalada = "Ensalada"
    case postre = "Postre"
    case bebida = "Bebida"
    case api = "API" // Para recetas obtenidas desde la API

    /// Mapea categorías desconocidas a un caso predeterminado
    static func from(rawValue: String) -> Categoria {
        return Categoria(rawValue: rawValue) ?? .api
    }
}

/// 📌 Modelo principal de receta
struct Recipe: Identifiable, Codable {
    let id: UUID
    let nombre: String
    let image: String
    let descripcion: String
    let ingredientes: String
    let pasos: String
    let categoria: Categoria
    let datePublished: String
    let url: String
    var isFavorite: Bool

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

