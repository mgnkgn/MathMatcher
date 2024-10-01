//
//  SettingsForm.swift
//  MathMatch
//
//  Created by Gunes Akgun on 30.09.2024.
//

import SwiftUI

struct SettingsForm: View {
	
	@EnvironmentObject var gameManager: GameManager
	@Binding var isSettingsVisible: Bool
	
    var body: some View {
		Form(content: {
			Section {
				Slider(value: Binding(get: {
					Double(gameManager.targetRange)
				}, set: { newRange in
					gameManager.targetRange = Int(newRange)
				}), in: 150...1000)
				
				Text("Target Number Range: -\(gameManager.targetRange) to \(gameManager.targetRange)")
					.frame(maxWidth: .infinity)
					.multilineTextAlignment(.center)
					.bold()
			}
			
			
			
			HStack {
				Spacer()
				Button(action: {
					isSettingsVisible = false
				}, label: {
					Text("Done")
				})
			}

		})
    }
}

#Preview {
	SettingsForm(isSettingsVisible: .constant(true))
}
