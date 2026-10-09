//
//  CategoriasView.swift
//  RecipeIA
//
//  NombreDelArchivo.swift
//  RecipeIA
//
//  Created by Nelson Ariel Villalba Vergara on 2025-03-17.
//  Copyright © 2025 Nelson Ariel Villalba Vergara. Todos los derechos reservados.
//
import SwiftUI

struct CategoriasView: View {
    @EnvironmentObject var recipesViewModel: RecipesViewModel
    @State private var nuevaCategoria = ""
    @State private var categoriaAEditar: CategoriaEditable?
    @State private var nuevoNombre = ""

    struct CategoriaEditable: Identifiable {
        var id: String { nombre }
        let nombre: String
    }

    var body: some View {
        NavigationView {
            ZStack {
                // Fondo claro personalizado
                Color("FondoClaro")
                    .ignoresSafeArea()

                VStack(spacing: 10) {
                    // Campo para añadir categoría
                    HStack {
                        TextField("Nueva categoría", text: $nuevaCategoria)
                            .padding(12)
                            .background(Color.white.opacity(0.95))
                            .cornerRadius(10)
                            .font(.system(size: 16, weight: .medium))

                        Button(action: {
                            let nueva = nuevaCategoria.trimmingCharacters(in: .whitespacesAndNewlines)
                            if !nueva.isEmpty {
                                recipesViewModel.agregarCategoria(nueva)
                                nuevaCategoria = ""
                            }
                        }) {
                            Text("Añadir")
                                .font(.system(size: 16, weight: .semibold))
                        }
                        .buttonStyle(BotonVerdeEstilo())
                    }
                    .padding(.horizontal)
                    .padding(.top, 20)

                    // Lista de categorías
                    List {
                        ForEach(recipesViewModel.categories, id: \.self) { categoria in
                            NavigationLink(destination: RecetasPorCategoriaView(categoria: Categoria.from(rawValue: categoria))) {
                                Text(categoria)
                                    .font(.system(size: 18, weight: .semibold))
                                    .padding(.vertical, 5)
                            }
                            .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                Button {
                                    categoriaAEditar = CategoriaEditable(nombre: categoria)
                                    nuevoNombre = categoria
                                } label: {
                                    Label("Editar", systemImage: "pencil")
                                }
                                .tint(.black)

                                Button(role: .destructive) {
                                    recipesViewModel.eliminarCategoria(categoria)
                                } label: {
                                    Label("Eliminar", systemImage: "trash")
                                }
                            }
                        }
                    }
                    .scrollContentBackground(.hidden)
                    .background(Color.clear)
                }
                .navigationTitle("Categorías")
                .font(.title2.bold())
            }
            .sheet(item: $categoriaAEditar) { categoriaEditable in
                VStack(spacing: 20) {
                    Text("Renombrar Categoría")
                        .font(.headline)

                    TextField("Nuevo nombre", text: $nuevoNombre)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    Button("Guardar") {
                        let nuevo = nuevoNombre.trimmingCharacters(in: .whitespacesAndNewlines)
                        if !nuevo.isEmpty && nuevo != categoriaEditable.nombre {
                            recipesViewModel.renombrarCategoria(nombreActual: categoriaEditable.nombre, nuevoNombre: nuevo)
                        }
                        categoriaAEditar = nil
                    }
                    .buttonStyle(BotonVerdeEstilo())
                    .padding(.horizontal)

                    Button("Cancelar") {
                        categoriaAEditar = nil
                    }
                    .foregroundColor(.red)
                }
                .padding()
            }
        }
    }
}

struct CategoriasView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriasView()
            .environmentObject(RecipesViewModel())
    }
}
