//
//  CustomButton.swift
//  MathMatch
//
//  Created by Gunes Akgun on 26.09.2024.
//

import SwiftUI

struct CustomButton: View {
    var title : String
    var font : Font = .largeTitle
    var color: Color = .blue
    
    var body: some View {
        Text(
            title
        )
        .font(
            font
        )
        .foregroundStyle(
            color.gradient
        )
        .bold()
        .padding()
        .background(
            RoundedRectangle(
                cornerRadius:  20
            )
            .stroke(color.gradient, lineWidth: 5)
        )
    }
}

#Preview {
    CustomButton(title: "Math Match", font: .title, color: .blue)
}
