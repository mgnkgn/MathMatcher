//
//  GameScreen.swift
//  MathMatch
//
//  Created by Gunes Akgun on 26.09.2024.
//

import SwiftUI

struct GameScreen: View {
    @EnvironmentObject var gameManager : GameManager
	
	@State private var scoreDifference: Int = 0
	@State private var showScoreDifference: Bool = false
	@State private var targetNumberColor: Color = .primary

    var body: some View {
			VStack {
				if gameManager.showGameOver && !gameManager.isAdModalVisible {
					GameOver()
				} else if !gameManager.showGameOver && !gameManager.isAdModalVisible {
					TimerLineView(
						remainingTime: gameManager.remainingTime,
						totalTime: 60
					)
					.frame(
						height: 5
					)
					
					
					HStack {
						Button(action: {
							gameManager.generateGrid()
						},
							   label: {
							Image(
								systemName: "shuffle"
							)
							.resizable()
							.scaledToFit()
							.frame(
								width: 30,
								height: 30
							)
							.foregroundStyle(
								.yellow.gradient
							)
						})
						.padding()
						Spacer()
						
						VStack(
							alignment: .trailing
						){
							ZStack(alignment: .trailing) {
								Text(
									"Score: \(gameManager.score)"
								)
								.font(
									.title2
								)
								.bold()
								.foregroundStyle(
									.green.gradient
								)
								
								if showScoreDifference {
									Text(
										"+\(scoreDifference)"
									)
									.font(
										.title3
									)
									.bold()
									.foregroundStyle(.green.gradient)
									.offset(y: -20)
									.transition(.opacity)
									.animation(.easeInOut(duration: 1.0), value: showScoreDifference)
									
								}
							}
							
							
							HStack{
								Text(
									"Bonus color:"
								)
								.font(
									.caption
								)
								RoundedRectangle(
									cornerRadius: 8
								)
								.fill(
									gameManager.bonusColor
								)
								.frame(
									width: 20,
									height: 20
								)
							}
							.foregroundStyle(
								gameManager.bonusColor
							)
						}
						.padding(.trailing, 10)
					}
					
					OperationPreview()
					
					HStack {
						Text(
							"You"
						)
						Text(
							"\(gameManager.usersNumber)"
						)
						.font(
							.largeTitle
						)
						.padding()
						.background(
							RoundedRectangle(
								cornerRadius: 10
							)
							.stroke(
								.primary,
								lineWidth: 2
							)
						)
						
						Text(
							"\(gameManager.targetNumber)"
						)
						.font(
							.largeTitle
						)
						.padding()
						.background(
							RoundedRectangle(
								cornerRadius: 10
							)
							.stroke(
								.primary,
								lineWidth: 2
							)
						)
						.foregroundStyle(targetNumberColor)
						.onChange(of: gameManager.targetNumber) { oldValue, newValue in
							withAnimation(.easeInOut(duration: 0.5)) {
								targetNumberColor = .green
							}
							
							DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
								withAnimation(.easeInOut(duration: 0.5)) {
									targetNumberColor = .primary
								}
							}
						}
						Text(
							"Match"
						)
					}
					GameGridView()
						.padding(
							.bottom
						)
					
					MathOperandsView()
					
				}
		}
        .onAppear(){
			gameManager.generateGrid()
            gameManager.generateTargetNumberAndBonusColor()
        }
		.onChange(of: gameManager.score, { oldValue, newValue in
			scoreDifference = newValue - oldValue
			
			showScoreDifference = true
			
			DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
				withAnimation {
					showScoreDifference = false
				}
			})
		})
		.sheet(isPresented: $gameManager.isAdModalVisible) {
			AdModalView()
		}
        .navigationTitle(
            "Math Match"
        )
        
    }
}

#Preview {
    GameScreen()
}
