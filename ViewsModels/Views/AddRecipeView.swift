//
//  AñadeRecetaView.swift
//  RecipeIA
//
//  NombreDelArchivo.swift
//  RecipeIA
//
//  Created by Nelson Ariel Villalba Vergara on 2025-03-17.
//  Copyright © 2025 Nelson Ariel Villalba Vergara. Todos los derechos reservados.
//
import SwiftUI

struct AddRecipeView: View {
    @EnvironmentObject var recipesViewModel: RecipesViewModel
    @Environment(\.dismiss) var dismiss

    @State private var nombre = ""
    @State private var descripcion = ""
    @State private var selectedCategoria: Categoria = .desayuno
    @State private var ingredientesTexto = ""
    @State private var pasosTexto = ""
    @State private var imagenUrl = ""

    @State private var mostrarAlerta = false

    var body: some View {
        ZStack {
            // Fondo degradado suave
            LinearGradient(
                gradient: Gradient(colors: [Color("FondoClaro"), Color.white]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Nueva Receta")
                        .font(.largeTitle.bold())
                        .padding(.top)

                    Group {
                        campoTexto(titulo: "Nombre", texto: $nombre)
                        campoTexto(titulo: "Descripción", texto: $descripcion)

                        Text("Categoría")
                            .font(.headline)
                            .padding(.horizontal)

                        Picker("Categoría", selection: $selectedCategoria) {
                            ForEach(Categoria.allCases, id: \.self) { categoria in
                                Text(categoria.rawValue).tag(categoria)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .padding()
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(10)
                        .padding(.horizontal)
                    }

                    Group {
                        campoTexto(titulo: "Ingredientes (separados por comas)", texto: $ingredientesTexto)
                        campoTexto(titulo: "Pasos (separados por comas)", texto: $pasosTexto)
                        campoTexto(titulo: "URL de la Imagen", texto: $imagenUrl)
                    }

                    Button(action: guardarReceta) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                            Text("Guardar Receta")
                                .fontWeight(.semibold)
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(BotonVerdeEstilo())
                    .padding(.top)
                    .padding(.horizontal)
                    .disabled(!isFormularioValido)
                }
                .padding(.bottom)
            }
        }
        .navigationTitle("Añadir Receta")
        .alert(isPresented: $mostrarAlerta) {
            Alert(
                title: Text("✅ Receta Guardada"),
                message: Text("La receta se ha añadido correctamente."),
                dismissButton: .default(Text("OK"), action: resetFields)
            )
        }
    }

    private func campoTexto(titulo: String, texto: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(titulo)
                .font(.headline)
                .padding(.horizontal)

            TextField(titulo, text: texto)
                .padding()
                .background(Color.white.opacity(0.9))
                .cornerRadius(10)
                .padding(.horizontal)
        }
    }

    private var isFormularioValido: Bool {
        !nombre.trimmingCharacters(in: .whitespaces).isEmpty &&
        !ingredientesTexto.trimmingCharacters(in: .whitespaces).isEmpty &&
        !pasosTexto.trimmingCharacters(in: .whitespaces).isEmpty
    }

    private func guardarReceta() {
        let nuevaReceta = Recipe(
            id: UUID(),
            nombre: nombre,
            image: imagenUrl.isEmpty ? "https://via.placeholder.com/300x200.png?text=Imagen+no+disponible" : imagenUrl,
            descripcion: descripcion.isEmpty ? "Sin descripción disponible." : descripcion,
            ingredientes: ingredientesTexto,
            pasos: pasosTexto,
            categoria: selectedCategoria,
            datePublished: ISO8601DateFormatter().string(from: Date()),
            url: "https://miappderecetas.com",
            isFavorite: false
        )

        recipesViewModel.agregarReceta(nuevaReceta)
        mostrarAlerta = true
    }

    private func resetFields() {
        nombre = ""
        descripcion = ""
        ingredientesTexto = ""
        pasosTexto = ""
        imagenUrl = ""
        selectedCategoria = .desayuno
        dismiss()
    }
}

struct AddRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        AddRecipeView()
            .environmentObject(RecipesViewModel())
    }
}
