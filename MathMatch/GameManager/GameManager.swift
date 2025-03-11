//
//  GameManager.swift
//  MathMatch
//
//  Created by Gunes Akgun on 26.09.2024.
//

import Foundation
import SwiftUI
import AVFoundation

struct Tile: Identifiable, Equatable {
    let id = UUID().uuidString
    var value : Int
    var isSelected : Bool = false
    var color: Color
}

class GameManager: ObservableObject {
    
    enum MathOperation {
        case addition, subtraction, multiplication, division
    }
    
    @Published var grid: [[Tile]] = []
    @Published var selectedTiles: [Tile] = []
    
    @Published var activeOperation : MathOperation = .addition
	@Published var usersNumber: Int = 0
    var rows = 9
    var columns = 9
    let colorOptions: [Color] = [
        .orange,
        .blue,
        .green
    ]
	
	var audioPlayer: AVAudioPlayer?
	
	var tileRange = 100
	@Published var targetRange : Int {
		didSet {
			UserDefaults.standard
				.set(
					targetRange,
					forKey: "targetRange"
				)
		}
	}
	@Published var targetNumber : Int = 100
	@Published var bonusColor: Color = .blue
	var guessCount: Int = 0
	var bonusColorUsageCount: Int = 0
	
	@Published var remainingTime: Int = 10
	var timer: Timer?
	@Published var showGameOver: Bool = false
	@Published var isAdModalVisible: Bool = false
	@Published var adShownCount: Int = 0
	
	@Published var userHasMatched: Bool = false
	@Published var score: Int = 0
	
	var tilePoint: Int = 10
	var colorPoint: Int = 5
	
	init() {
		self.targetRange = UserDefaults.standard
			.integer(
				forKey: "targetRange"
			)
		if targetRange == 0 {
			targetRange = 500
		}
	}
	
	
	
	
	
	
	func generateTargetNumberAndBonusColor(){
		targetNumber = Int
			.random(
				in: -targetRange...targetRange
			)
		bonusColor = colorOptions
			.randomElement() ?? .blue
		guessCount = 0
		bonusColorUsageCount = 0
		showGameOver = false
		startTimer()
	}
	
	func generateGrid(){
		grid
			.removeAll()
		
		for _ in 0..<rows {
			var row: [Tile] = []
			
			
			for _ in 0..<columns {
				let randomValue = Int.random(
					in: -tileRange...tileRange
				)
				withAnimation{
					row
						.append(
							Tile(
								value: randomValue,
								color: colorOptions
									.randomElement() ?? .blue
							)
						)
				}
			}
			
			grid
				.append(
					row
				)
		}
		
	}
	
	func selectTile(
		tile: Tile
	){
		playTapSound()
		
		for row in 0..<rows {
			for col in 0..<columns {
				if grid[row][col].id == tile.id && grid[row][col].value == tile.value {
					grid[row][col].isSelected
						.toggle()
					// Check if the tile is already in the selectedTiles array
					if let index = selectedTiles.firstIndex(
						where: {
							$0.id == tile.id
						}) {
						
						// Tile is already selected, so remove it from selectedTiles
						selectedTiles
							.remove(
								at: index
							)
					} else {
						
						// Tile is not selected, so add it to selectedTiles
						selectedTiles
							.append(
								grid[row][col]
							)
					}
					
					break
				}
			}
		}
	}
	
	func clearSelectedTiles(){
		selectedTiles
			.removeAll()
	}
	
	func performOperation() {
		
		var result: Int?
		
		guessCount += 1
		
		let selectedBonusTiles = selectedTiles.filter {
			$0.color == bonusColor
		}
		bonusColorUsageCount += selectedBonusTiles.count
		
		switch activeOperation {
		case .addition:
			result = selectedTiles
				.reduce(
					usersNumber,
					{
						partialResult,
						tile in
						partialResult + tile.value
					})
			
		case .subtraction:
			result = selectedTiles
				.reduce(
					usersNumber,
					{
						partialResult,
						tile in
						partialResult - tile.value
					})
			
		case .multiplication:
			result = selectedTiles
				.reduce(
					usersNumber == 0 ? 1 : usersNumber,
					{
						partialResult,
						tile in
						partialResult * tile.value
					})
			
		case .division:
			result = selectedTiles
				.reduce(
					usersNumber,
					{
						partialResult,
						tile in
						tile.value != 0 ? Int(
							floor(
								Double(
									partialResult
								) / Double(
									tile.value
								)
							)
						) : partialResult
					})
		}
		
		popTilesAndDrop()
		
		if let result = result {
			usersNumber = result
			
			checkNumbersMatch()
		}
		
		clearSelectedTiles()
		
		
	}
	
	func checkNumbersMatch() {
		
		if usersNumber == targetNumber {
			playSuccessSound()
			calculateScore()
			generateTargetNumberAndBonusColor()
		}
	}
	
	func calculateScore(){
		let baseScore = selectedTiles.count * tilePoint
		let bonusColorScore = bonusColorUsageCount * colorPoint
		let guessMultiplier: Double = max(
			1.0,
			5.0 - Double(
				guessCount
			)
		)
		
		let finalScore = Int(
			(
				Double(
					baseScore + bonusColorScore
				) * guessMultiplier
			)
		)
		
		withAnimation{
			score += finalScore
		}
	}
	
	
	// Updates grid and pops tiles and makes the tiles above fall down
	func popTilesAndDrop() {
		selectedTiles
			.forEach { tile in
				for row in 0..<rows {
					for col in 0..<columns {
						if grid[row][col].id == tile.id {
							if row>0 {
								for dropRow in (
									1...row
								).reversed() {
									withAnimation {
										grid[dropRow][col] = grid[dropRow - 1][col]
										grid[dropRow][col].isSelected = false
									}
								}
							}
							
							withAnimation {
								grid[0][col] = Tile(
									value: Int
										.random(
											in: -100...100
										),
									isSelected: false,
									color: colorOptions
										.randomElement() ?? .blue
								)
							}
							
						}
						
						
					}
				}
			}
	}
	
	func startTimer() {
		remainingTime = 60
		userHasMatched = false
		
		timer?
			.invalidate()
		
		timer = Timer
			.scheduledTimer(
				withTimeInterval: 1.0,
				repeats: true
			) { [weak self] _ in
				guard let self = self else {
					return
				}
				
				if self.remainingTime > 0 {
					self.remainingTime -= 1
				} else {
					self.timer?
						.invalidate()
					self.handleTimeOut()
					playTimesUpSound()
				}
			}
	}
	
	func playSuccessSound() {
		guard let url = Bundle.main.url(
			forResource: "success_sound",
			withExtension: "mp3"
		) else {
			return
		}
		
		do {
			audioPlayer = try AVAudioPlayer(
				contentsOf: url
			)
			audioPlayer?.volume = 0.3
			audioPlayer?
				.play()
		} catch let error {
			print(
				"Error playing success sound: \(error.localizedDescription)"
			)
		}
	}
	
	func playTimesUpSound() {
		guard let url = Bundle.main.url(
			forResource: "times_up",
			withExtension: "mp3"
		) else {
			return
		}
		
		if showGameOver || isAdModalVisible {
			do {
				audioPlayer = try AVAudioPlayer(
					contentsOf: url
				)
				audioPlayer?
					.play()
			} catch let error {
				print("Error playing success sound: \(error.localizedDescription)")
			}
		}
	}
	
	func playTapSound(){
		guard let url = Bundle.main.url(forResource: "tap_sound", withExtension: "mp3") else {
			return
		}
		
		do {
			audioPlayer = try AVAudioPlayer(
				contentsOf: url
			)
			audioPlayer?
				.play()
		} catch let error {
			print("Error playing success sound: \(error.localizedDescription)")
		}
	}
	
	func handleTimeOut() {
		if adShownCount == 0 {
			isAdModalVisible = true
			adShownCount += 1
		} else {
			showGameOver = true
			isAdModalVisible = false
		}
	}
	
	func stopTimer() {
		timer?.invalidate()
		timer = nil
	}
	
	func stopSounds(){
		audioPlayer?.stop()
		audioPlayer = nil
	}
	
	func restartGame() {
			adShownCount = 0
			score = 0
			remainingTime = 60
			usersNumber = 0
			showGameOver = false
			isAdModalVisible = false
			generateTargetNumberAndBonusColor()
			generateGrid()
			startTimer()
	}
    
}
