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
    var timestamp: Date
	var playerName: String
	var score: Int
	
	init(timestamp: Date, playerName: String, score: Int) {
        self.timestamp = timestamp
		self.playerName = playerName
		self.score = score
    }
}
