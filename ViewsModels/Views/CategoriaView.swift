//
//  CategoriaView.swift
//
//


import SwiftUI

struct CategoryView: View {
    @EnvironmentObject var recipesViewModel: RecipesViewModel
    var category: Categoria
    
    // Filtra recetas por categoría
    var recipes: [Recipe] {
        return recipesViewModel.userRecipes.filter { $0.categoria == category }
    }
    
    var body: some View {
        ZStack {
            // Fondo degradado
            LinearGradient(
                gradient: Gradient(colors: [Color("FondoClaro"), Color.white]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            if recipes.isEmpty {
                VStack(spacing: 16) {
                    Image(systemName: "fork.knife")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .foregroundColor(.gray.opacity(0.6))
                    Text("No hay recetas en esta categoría.")
                        .font(.title3)
                        .foregroundColor(.gray)
                }
                .padding()
            } else {
                ScrollView {
                    RecipeList(recipes: recipes)
                        .padding()
                }
            }
        }
        .navigationTitle(category.rawValue + "s")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView(category: .desayuno)
            .environmentObject(RecipesViewModel())
    }
}
