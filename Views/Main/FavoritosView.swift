//
//  FavoritosView.swift
//
//
//
//

import SwiftUI

struct FavoritosView: View {
    var body: some View {
        NavigationView {
            Text("¡Aún no has añadido ninguna receta a tus favoritos!")
                .multilineTextAlignment(.center)
                .padding()
                .navigationTitle("Favoritos")
        }
        .navigationViewStyle(.stack)
    }
}

struct FavoritosView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritosView()
    }
}
