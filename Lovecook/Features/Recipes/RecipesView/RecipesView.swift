//
//  RecipesView.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 8/12/23.
//

import SwiftUI

struct RecipesView: View {
    var meal: Meal
    @StateObject private var viewModel: RecipesViewModel
    @EnvironmentObject var coordinator: Coordinator
    
    init(meal: Meal, viewModel: RecipesViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.meal = meal
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    let coordinator = Coordinator()
    return coordinator.makeRecipesView(for: .example).environmentObject(coordinator)
}
