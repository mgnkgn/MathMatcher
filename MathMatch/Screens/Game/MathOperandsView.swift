//
//  MathOperandsView.swift
//  MathMatch
//
//  Created by Gunes Akgun on 26.09.2024.
//

import SwiftUI

struct MathOperandsView: View {
    @EnvironmentObject var gameManager : GameManager
    var body: some View {
        
        
        
        HStack(spacing: 20) {
            
            Button(action: {
                withAnimation {
                    gameManager.activeOperation = .addition
                }
            }, label: {
                Image(systemName: "plus.square")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .foregroundStyle(.green.gradient)
                    .scaleEffect(gameManager.activeOperation == .addition ? 1.3 : 1)
                
            })
            
            Button(action: {
                withAnimation {
                    gameManager.activeOperation = .subtraction
                }
            }, label: {
                Image(systemName: "minus.square")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .foregroundStyle(.orange.gradient)
                    .scaleEffect(gameManager.activeOperation == .subtraction ? 1.3 : 1)
            })
            
            Button(action: {
                withAnimation {
                    gameManager.activeOperation = .multiplication
                }
            }, label: {
                Image(systemName: "multiply.square")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .foregroundStyle(.blue.gradient)
                    .scaleEffect(gameManager.activeOperation == .multiplication ? 1.3 : 1)
            })
            
            Button(action: {
                withAnimation {
                    gameManager.activeOperation = .division
                }
            }, label: {
                Image(systemName: "divide.square")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .foregroundStyle(.red.gradient)
                    .scaleEffect(gameManager.activeOperation == .division ? 1.3 : 1)
            })
            
            Button(action: {
                gameManager.performOperation()
            }, label: {
                Image(systemName: "equal.square")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .foregroundStyle(Color.primary)
            })
            
            
            
            
            
        }
    }
}

#Preview {
    MathOperandsView()
}
