//
//  RecipeView.swift
//
//
//
//
import Foundation
import SwiftUI

struct RecipeView: View {
    var recipe: Recipe

    var body: some View {
        ScrollView {
            AsyncImage(url: URL(string: recipe.image)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(height: 300)
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 300)
                        .clipped()
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 300)
                        .foregroundColor(.gray)
                @unknown default:
                    EmptyView()
                }
            }
            .frame(maxWidth: .infinity)
            .background(LinearGradient(gradient: Gradient(colors: [Color.gray.opacity(0.3), Color.gray]), startPoint: .top, endPoint: .bottom))

            VStack(spacing: 30) {
                Text(recipe.nombre)
                    .font(.largeTitle)
                    .bold()
                    .multilineTextAlignment(.center)

                VStack(alignment: .leading, spacing: 30) {
                    if !recipe.descripcion.isEmpty {
                        Text(recipe.descripcion)
                    }
                    if !recipe.ingredientes.isEmpty {
                        VStack(alignment: .leading, spacing: 20) {
                            Text("Ingredientes")
                                .font(.headline)
                            Text(recipe.ingredientes)
                        }
                    }
                    if !recipe.pasos.isEmpty {
                        VStack(alignment: .leading, spacing: 20) {
                            Text("Pasos")
                                .font(.headline)
                            Text(recipe.pasos)
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
        .navigationTitle(recipe.nombre) // 🔹 Confirmar título de la receta
        .ignoresSafeArea(.container, edges: .top)
    }
}

struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView(recipe: Recipe.all[0])
    }
}
