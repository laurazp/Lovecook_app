//
//  GreenRoundedButton.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 5/1/24.
//

import SwiftUI

struct GreenRoundedButton: View {
    let buttonText: String
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(buttonText)
                .frame(maxWidth: .infinity)
                .fontWeight(.bold)
                .foregroundColor(Color.white)
        }
        .cornerRadius(20)
        .buttonStyle(.borderedProminent)
        .tint(Color.lightGreen)
        .controlSize(.large)
    }
}

#Preview {
    GreenRoundedButton(buttonText: "Sign up", action: {})
}
