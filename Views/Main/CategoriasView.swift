//
//  CategoriasView.swift
//  
//
//
//

import SwiftUI

struct CategoriasView: View {
    var body: some View {
        NavigationView {
            List {
                ForEach(Categoria.allCases.filter { $0 != .api && $0 != .api }) { categoria in
                    NavigationLink(destination: CategoriaView(categoria: categoria)) {
                        Text(categoria.rawValue)
                            .font(.system(size: 18, weight: .medium))
                    }
                }
            }
            .navigationTitle("Categorías")
        }
        .navigationViewStyle(.stack)
    }
}

struct CategoriasView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriasView()
    }
}
