//
//  ContentView.swift
//  import SwiftUI
import SwiftUI

struct ContentView: View {
    var body: some View {
        TabBar() // Asegúrate de que TabBar sea la vista principal
            .environmentObject(RecipesViewModel()) // Pasar el ViewModel globalmente
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(RecipesViewModel())
    }
}
