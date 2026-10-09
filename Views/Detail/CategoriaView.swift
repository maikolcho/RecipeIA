//
//  CategoriaView.swift
//
//

import SwiftUI

struct CategoriaView: View {
    @EnvironmentObject var recipesViewModel: RecipesViewModel
    var categoria: Categoria

    var recipes: [Recipe] {
        return recipesViewModel.recipes.filter { $0.categoria == categoria }
    }

    var body: some View {
        ScrollView {
            RecipeList(recipes: recipes)
        }
        .navigationTitle(categoria.rawValue + "s")
    }
}

struct CategoriaView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriaView(categoria: .api)
            .environmentObject(RecipesViewModel())
    }
}
