//
//  FondoView.swift
//  RecipeIA
//
//  Created by Maik on 26/3/25.
//

import Foundation
import SwiftUI

struct FondoView<Content: View>: View {
    let content: () -> Content

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color("FondoClaro"), Color.white]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            content()
        }
    }
}
