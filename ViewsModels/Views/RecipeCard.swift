//
//  RecetaX.swift
//
//  NombreDelArchivo.swift
//  RecipeIA
//
//  Created by Nelson Ariel Villalba Vergara on 2025-03-17.
//  Copyright © 2025 Nelson Ariel Villalba Vergara. Todos los derechos reservados.
//

import SwiftUI

struct RecipeCard: View {
    var recipe: Recipe

    var body: some View {
        VStack(spacing: 0) {
            AsyncImage(url: URL(string: recipe.image)) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 160, height: 217)
                    .clipped()
                    .overlay(
                        VStack {
                            Spacer()
                            Text(recipe.nombre)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.vertical, 6)
                                .padding(.horizontal, 8)
                                .frame(maxWidth: .infinity)
                                .background(Color.black.opacity(0.5))
                                .foregroundColor(.white)
                        }
                    )
            } placeholder: {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.gray.opacity(0.15))
                    VStack {
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.gray.opacity(0.6))

                        Text(recipe.nombre)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.gray)
                            .padding(.top, 4)
                    }
                }
                .frame(width: 160, height: 217)
            }
        }
        .frame(width: 160)
        .background(Color.white.opacity(0.95))
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Color.black.opacity(0.08), radius: 6, x: 0, y: 3)
        .padding(.bottom, 8) // Espacio limpio entre tarjetas
    }
}
