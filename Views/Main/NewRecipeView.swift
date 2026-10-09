//
//  NuevaRecetaView.swift
//
//
//
//

import SwiftUI

struct NewRecipeView: View {
    @State private var showAddRecipe = false

    var body: some View {
        NavigationView {
            VStack {
                Button("Añadir Receta Manualmente") {
                    showAddRecipe = true
                }
                .font(.title2)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding()
            }
            .navigationTitle("Nueva Receta")
        }
        .sheet(isPresented: $showAddRecipe) {
            AddRecipeView()
                .environmentObject(RecipesViewModel())
        }
    }
}

struct NewRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        NewRecipeView()
    }
}
