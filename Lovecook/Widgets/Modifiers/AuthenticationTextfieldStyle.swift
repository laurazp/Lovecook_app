//
//  CustomTextfieldStyle.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 6/1/24.
//

import SwiftUI

struct AuthenticationTextfieldStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
    }
}

extension View {
    func authenticationTextfieldStyle() -> some View {
        modifier(AuthenticationTextfieldStyle())
    }
}
