//
//  ScoreForm.swift
//  MathMatch
//
//  Created by Gunes Akgun on 30.09.2024.
//

import SwiftUI

struct ScoreForm: View {
	@Environment(
		\.modelContext
	) private var context
	@EnvironmentObject var gameManager: GameManager
	@State var playerName: String = ""
	@Binding var scoreModalIsVisible : Bool
	
	var body: some View {
		VStack {
			HStack {
				Button {
					scoreModalIsVisible = false
				} label: {
					Text("Cancel")
				}

			}
			
			Form(
				content: {
					Section {
						TextField(
							"Player name",
							text: $playerName
						)
						
					}
					
					Button(
						action: {
							saveScore()
							scoreModalIsVisible = false
						},
						label: {
							Text(
								"Done"
							)
						})
					.disabled(
						playerName.isEmpty
					)
				})
		}
	}
	
	
	func saveScore() {
		let playerScore = Score(
			playerName: playerName,
			score: gameManager.score
		)
		context
			.insert(
				playerScore
			)
	}
}

#Preview {
	ScoreForm(
		scoreModalIsVisible: .constant(
			true
		)
	)
}
