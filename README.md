# RecipeIA 🍳📱

Aplicación iOS desarrollada con **SwiftUI** y arquitectura **MVVM** que genera recetas con **inteligencia artificial** a partir de los ingredientes que tienes en casa.

Escribes tus ingredientes separados por comas y la app pide a **Gemini** (Google) tres recetas en español, con ingredientes y cantidades, pasos numerados y categoría. Puedes guardarlas en favoritos, crear tus propias recetas y organizarlo todo en categorías.

## ✨ Funcionalidades
- 🤖 Generación de recetas con IA (API de Gemini) a partir de los ingredientes disponibles
- 🛟 Respaldo automático: si la IA no está disponible, busca alimentos en la API de Nutritionix
- 🥕 Búsqueda también entre tus recetas guardadas
- 🏠 Inicio con buscador por nombre
- 🗂️ Categorías por defecto (Desayuno, Sopa, Ensalada, Postre, Carne, Mariscos) que se pueden añadir, renombrar y borrar
- ⭐ Favoritos, con borrado por deslizamiento
- ✍️ Creación de recetas propias
- 💾 Datos guardados en el dispositivo (JSON en `UserDefaults`)

## 🛠️ Tecnologías
- Swift y SwiftUI (Xcode)
- Arquitectura MVVM (`ObservableObject`, `@Published`, `@MainActor`)
- Concurrencia moderna con `async/await`
- Consumo de APIs REST con `URLSession`: Gemini (`generateContent`) y Nutritionix
- Persistencia local con `Codable` y `UserDefaults`

## ▶️ Cómo ejecutarlo
1. Clona el repositorio y abre `RecipeIA.xcodeproj` en Xcode.
2. Copia `RecipeIA/Secrets.swift.example` como `RecipeIA/Secrets.swift` y rellena tus claves:
   - **Gemini** (gratis con límites): https://aistudio.google.com/apikey
   - **Nutritionix** (opcional, para el respaldo): https://developer.nutritionix.com
3. Elige un simulador de iPhone y pulsa **Cmd + R**.

`Secrets.swift` está en `.gitignore`, así que tus claves nunca se suben al repositorio.

> ⚠️ Las claves van dentro de la app. Es suficiente para un proyecto personal, pero una app publicada debería llamar a la IA a través de un servidor propio.

## 🎯 Objetivo del proyecto
Proyecto personal con fines formativos y de portfolio: integración de APIs externas (incluida IA generativa), SwiftUI, MVVM y persistencia local.

## 📌 Estado
En desarrollo activo.

## 👨‍💻 Autor
Nelson Ariel Villalba Vergara
