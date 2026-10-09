//
//  HomeView.swift
//
//
//
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var recipesViewModel: RecipesViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                RecipeList(recipes: recipesViewModel.recipes)
            }
            .navigationTitle(" ")
        }
        .navigationViewStyle(.stack)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(RecipesViewModel())
    }
}
