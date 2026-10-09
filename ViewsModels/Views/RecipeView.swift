//
//  RecipeView.swift
//
//  NombreDelArchivo.swift
//  RecipeIA
//
//  Created by Nelson Ariel Villalba Vergara on 2025-03-17.
//  Copyright © 2025 Nelson Ariel Villalba Vergara. Todos los derechos reservados.
//

import SwiftUI

struct RecipeView: View {
    @EnvironmentObject var recipesViewModel: RecipesViewModel
    var recipe: Recipe

    var body: some View {
        ZStack {
            // Fondo degradado suave
            LinearGradient(
                gradient: Gradient(colors: [Color("FondoClaro"), Color.white]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Nombre de la receta
                    Text(recipe.nombre)
                        .font(.system(size: 26, weight: .bold))
                        .foregroundColor(.primary)

                    // Imagen con placeholder y estilo
                    if let imagenUrl = URL(string: recipe.image), !recipe.image.isEmpty {
                        AsyncImage(url: imagenUrl) { image in
                            image
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            ProgressView()
                                .frame(width: 150, height: 150)
                        }
                        .frame(maxWidth: .infinity, maxHeight: 250)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .shadow(radius: 5)
                    }

                    // Ingredientes
                    Text("🧂 Ingredientes")
                        .font(.title3.bold())
                        .padding(.bottom, 2)

                    Text(recipe.ingredientes)
                        .font(.body)

                    // Pasos
                    Text("👨‍🍳 Pasos de Preparación")
                        .font(.title3.bold())
                        .padding(.top)

                    Text(recipe.pasos)
                        .font(.body)

                    // Botón de favoritos
                    Button(action: {
                        recipesViewModel.toggleFavorite(recipe: recipe)
                    }) {
                        HStack {
                            Image(systemName: recipesViewModel.esRecetaFavorita(recipe) ? "heart.fill" : "heart")
                            Text(recipesViewModel.esRecetaFavorita(recipe) ? "Quitar de Favoritos" : "Añadir a Favoritos")
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .padding()
                
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .padding(.top)
                }
                .padding()
            }
        }
        .navigationTitle(recipe.nombre)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView(recipe: Recipe(
            id: UUID(),
            nombre: "Ejemplo Receta",
            image: "https://example.com/imagen.jpg",
            descripcion: "Una receta de prueba",
            ingredientes: "Ingrediente 1, Ingrediente 2",
            pasos: "Paso 1, Paso 2",
            categoria: .desayuno,
            datePublished: "2024-03-30",
            url: "https://example.com"
        ))
        .environmentObject(RecipesViewModel())
    }
}
