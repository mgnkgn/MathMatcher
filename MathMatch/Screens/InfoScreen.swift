//
//  InfoScreen.swift
//  MathMatcher
//
//  Created by Gunes Akgun on 2.10.2024.
//

import SwiftUI

struct InfoScreen: View {
	@Binding var isInfoVisible: Bool
	
	var body: some View {
		
		HStack {
			Spacer()
			Button {
				isInfoVisible = false
			} label: {
				Text("Done")
					.bold()
					.padding()
			}
		}

		ScrollView {
			VStack(alignment: .leading, spacing: 20) {
				Text("Math Mixer Game Instructions")
					.font(.largeTitle)
					.bold()
					.padding(.bottom, 10)

				// Gameplay Section
				Text("Gameplay:")
					.font(.title2)
					.bold()
				Text("In Math Mixer, your goal is to match numbers on the tiles to achieve the target number displayed. Use basic arithmetic operations to create combinations and score points!")
					.font(.body)
				
				// Division Explanation
				Text("⚠️ Division & Rounding:")
					.font(.title2)
					.bold()
				Text("When using division, the result is always rounded **down** (floor division). This means that any remainder is ignored. For example:")
					.font(.body)
				Text("➜ 10 ÷ 3 = 3 (not 3.33)\n➜ 7 ÷ 2 = 3 (not 3.5)\n➜ 5 ÷ 5 = 1")
					.font(.body)
					.foregroundColor(.blue)

				// Scoring Section
				Text("Scoring:")
					.font(.title2)
					.bold()
				Text("Earn points by matching numbers correctly. Each successful match will contribute to your score. Additionally, bonus points can be earned by using special tiles!")
					.font(.body)

				// Tips Section
				Text("Tips:")
					.font(.title2)
					.bold()
				Text("1. Keep an eye on the timer! \n2. Plan your moves carefully to maximize your score. \n3. Use the 'Shuffle' button to rearrange tiles if you're stuck. \n4. Be careful with division – it always rounds down!")
					.font(.body)
				
				// Additional Notes Section
				Text("Additional Notes:")
					.font(.title2)
					.bold()
				Text("You can watch ads to earn extra chances. Enjoy the game and challenge your math skills!")
					.font(.body)

				Spacer()
			}
			.padding()
		}
		.navigationTitle("Game Info")
		.navigationBarTitleDisplayMode(.inline)
	}
}

#Preview {
	InfoScreen(isInfoVisible: .constant(true))
}
