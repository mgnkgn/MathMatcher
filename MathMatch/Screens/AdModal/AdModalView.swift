//
//  AdModalView.swift
//  MathMatch
//
//  Created by Gunes Akgun on 1.10.2024.
//

import SwiftUI

struct AdModalView: View {
	@EnvironmentObject var gameManager: GameManager
	@StateObject private var rewardViewModel = RewardedViewModel()
	@Environment(\.dismiss) var dismiss
	
	
	var body: some View {
		VStack {
			Text("Do you want to watch an ad for extra chance?")
				.font(.largeTitle)
				.padding()
			
			HStack {
				Button(action: {
					Task {
						rewardViewModel.gameManager = gameManager
						await rewardViewModel.loadAd()
						rewardViewModel.showAd()
					}
					
					gameManager.isAdModalVisible = false
					gameManager.startTimer()
				}, label: {
					Text("Yes")
						.bold()
						.padding()
						.frame(maxWidth: .infinity)
						.background(Color.green)
						.foregroundColor(.white)
						.cornerRadius(10)
				})
				
				Button(action: {
					gameManager.isAdModalVisible = false
					gameManager.showGameOver = true
					dismiss()
				}, label: {
					Text("Close")
						.bold()
						.padding()
						.frame(maxWidth: .infinity)
						.background(Color.red)
						.foregroundColor(.white)
						.cornerRadius(10)
				})
			}
			.padding()
		}
		.padding()
	}
}

#Preview {
	AdModalView()
}
