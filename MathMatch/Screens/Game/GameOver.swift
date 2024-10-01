//
//  GameOver.swift
//  MathMatch
//
//  Created by Gunes Akgun on 28.09.2024.
//

import SwiftUI

struct GameOver: View {
	
	@EnvironmentObject var gameManager: GameManager
	@State var scoreModalVisible: Bool = false
	@State var playerName: String = ""
	
	@Environment(\.modelContext) private var context
	@Environment(\.dismiss) private var dismiss
	
    var body: some View {
		VStack {
					Text("Game Over")
					   .font(.largeTitle)
					   .bold()
					   .padding()
				   
				    Text("Your Score: \(gameManager.score)")
					   .font(.title)
					   .padding()
				   
				
			VStack {
				
				Button(action: {
					dismiss()
				}, label: {
					CustomButton(
						title: "Main Menu",
						font: .title3,
						color: .blue
					)
				})
				HStack {
					Button(action: {
						scoreModalVisible = true
					}) {
						CustomButton(
							title: "Save Score",
							font: .title3,
							color: .green
							
						)
					}
					
					Button(action: {
						gameManager.generateGrid()
						gameManager.generateTargetNumberAndBonusColor()
					}) {

						CustomButton(
							title: "Restart",
							font: .title3,
							color: .orange
						)
					}
				}
				.padding()
			}
			   }
			.sheet(isPresented: $scoreModalVisible, content: {
				ScoreForm(scoreModalIsVisible: $scoreModalVisible)
			})
			.frame(maxWidth: .infinity, maxHeight: .infinity)
			   .background(Color.black.opacity(0.6))
			   .ignoresSafeArea()
    }
	
	
	
}

#Preview {
    GameOver()
}
