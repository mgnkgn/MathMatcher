//
//  Item.swift
//  MathMatch
//
//  Created by Gunes Akgun on 26.09.2024.
//

import Foundation
import SwiftData

@Model
final class Score {
	var playerName: String
	var score: Int
	
	init(
		playerName: String,
		score: Int
	) {
		self.playerName = playerName
		self.score = score
	}
}

struct MockData {
	static let sampleScore = Score(
		playerName: "Player 1",
		score: 1000
	)
	
	static let sampleScores:  [Score] = [
		Score(
			playerName: "Player 1",
			score: 1000
		),
		Score(
			playerName: "Player 2",
			score: 850
		),
		Score(
			playerName: "Player 3",
			score: 1200
		),
		Score(
			playerName: "Player 4",
			score: 950
		),
		Score(
			playerName: "Player 5",
			score: 1100
		)
]
}
