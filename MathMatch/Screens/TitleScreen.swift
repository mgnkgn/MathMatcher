//
//  TitleScreen.swift
//  MathMatch
//
//  Created by Gunes Akgun on 26.09.2024.
//

import SwiftUI

struct TitleScreen: View {
    
    @EnvironmentObject var gameManager: GameManager
	@State var isSettingsVisible: Bool = false
	@State var isInfoVisible: Bool = false
	
    var body: some View {
        NavigationStack{
			HStack {
				Button {
					isInfoVisible = true
				} label: {
					Image(systemName: "info.circle")
						.bold()
				}

				Spacer()
				Button(action: {
					isSettingsVisible = true
				}, label: {
					Image(systemName: "gearshape")
						.bold()
				})
			}
			.padding()
			
			Spacer()
			
            VStack {
                // Title
                CustomButton(
                    title: "Math Mixer",
                    font: .largeTitle,
                    color: .blue
                )
                
                
                HStack {
                    // Play button
                    NavigationLink(
                        destination: GameScreen()
							.onTapGesture {
								gameManager.generateTargetNumberAndBonusColor()
							}

                    ){  CustomButton(
                        title: "Play",
                        font: .title2,
                        color: .green
                    )
					}
						
                    
                    
                    // Scoreboard button
                    NavigationLink(
                        destination: ScoreboardScreen()
                    ) {
                        CustomButton(
                            title: "Scoreboard",
                            font: .title2,
                            color: .orange
                        )
                    }
                
                }
            }
			
			Spacer()
        }
		.sheet(isPresented: $isSettingsVisible, content: {
			SettingsForm(isSettingsVisible: $isSettingsVisible)
		})
		.sheet(isPresented: $isInfoVisible, content: {
			InfoScreen(isInfoVisible: $isInfoVisible)
		})

        
                
            	
            

    }
}

#Preview {
    TitleScreen()
}
