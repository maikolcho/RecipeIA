//
//  AñadeRecetaView.swift
//
//
//
//
import SwiftUI

struct AddRecipeView: View {
    @EnvironmentObject var recipesViewModel: RecipesViewModel
    @State private var nombre: String = ""
    @State private var selectedCategoria: Categoria = .desayuno
    @State private var descripcion: String = ""
    @State private var ingredientes: String = ""
    @State private var pasos: String = ""

    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Nombre")) {
                    TextField("Nombre de la receta", text: $nombre)
                }
                Section(header: Text("Categoría")) {
                    Picker("Categoría", selection: $selectedCategoria) {
                        ForEach(Categoria.allCases, id: \.self) { categoria in
                            Text(categoria.rawValue).tag(categoria)
                        }
                    }
                    .pickerStyle(.menu)
                }
                Section(header: Text("Descripción")) {
                    TextEditor(text: $descripcion)
                }
                Section(header: Text("Ingredientes")) {
                    TextEditor(text: $ingredientes)
                }
                Section(header: Text("Pasos")) {
                    TextEditor(text: $pasos)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button { dismiss() } label: {
                        Label("Cancelar", systemImage: "xmark.circle.fill")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        saveRecipe()
                        dismiss()
                    } label: {
                        Label("Guardar", systemImage: "checkmark.circle.fill")
                    }
                    .disabled(nombre.isEmpty)
                }
            }
            .navigationTitle("Añadir Receta")
        }
    }

    private func saveRecipe() {
        let recipe = Recipe(
            nombre: nombre,
            image: "https://via.placeholder.com/150",
            descripcion: descripcion,
            ingredientes: ingredientes,
            pasos: pasos,
            categoria: selectedCategoria,
            datePublished: ISO8601DateFormatter().string(from: Date()),
            url: ""
        )
        recipesViewModel.addRecipe(recipe: recipe)
    }
}

struct AddRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        AddRecipeView().environmentObject(RecipesViewModel())
    }
}
