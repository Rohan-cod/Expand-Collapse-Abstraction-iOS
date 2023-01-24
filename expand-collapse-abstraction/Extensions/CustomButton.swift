//
//  CustomButton.swift
//  expand-collapse-abstraction
//
//  Created by Rohan  Gupta on 24/01/23.
//

import SwiftUI

struct CustomButton: View {
    var buttonText: String
    var action: () -> ()
    
    private let buttonHeight: CGFloat = 40
    private let buttonWidth: CGFloat = UIScreen.main.bounds.width * 0.6
    private let buttonCornerRadius: CGFloat = 10

    var body: some View {
        Button {
            action()
        } label: {
            Text(buttonText)
                .font(Font.title3)
                .frame(width: buttonWidth, height: buttonHeight)
                .background {
                    Color.brown
                }
                .cornerRadius(buttonCornerRadius)
                .foregroundColor(.mint)
        }

    }
}
