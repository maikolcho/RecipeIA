import Foundation

/// Datos de ejemplo para las previsualizaciones de SwiftUI (#Preview / PreviewProvider).
extension Recipe {
    static let all: [Recipe] = [
        Recipe(
            nombre: "Ensalada de tomate y aguacate",
            image: "",
            descripcion: "Ensalada fresca y rápida con tomate, aguacate y aceite de oliva.",
            ingredientes: "2 tomates, 1 aguacate, aceite de oliva, sal",
            pasos: "Corta los tomates y el aguacate, mezcla y aliña con aceite y sal.",
            categoria: .ensalada,
            datePublished: "2026-01-01",
            url: ""
        ),
        Recipe(
            nombre: "Sopa de verduras",
            image: "",
            descripcion: "Sopa casera con verduras de temporada.",
            ingredientes: "Zanahoria, patata, puerro, caldo",
            pasos: "Cuece las verduras en el caldo durante 25 minutos y tritura.",
            categoria: .sopa,
            datePublished: "2026-01-02",
            url: ""
        )
    ]
}
