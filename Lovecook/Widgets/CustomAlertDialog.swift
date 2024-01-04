//
//  AlertDialog.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 4/1/24.
//

import SwiftUI

struct CustomAlertDialog {
    
    func makeAlertDialog(title: String, message: String, primaryBtnText: String, secondaryBtnText: String, primaryBtnAction: @escaping () -> Void) -> Alert {
        
        return Alert(
            title: Text(title),
            message: Text(message),
            primaryButton: .default(
                Text(primaryBtnText),
                action: primaryBtnAction),
            secondaryButton: .cancel(Text(secondaryBtnText))
        )
    }
}
