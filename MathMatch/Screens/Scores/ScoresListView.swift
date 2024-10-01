//
//  ScoresListView.swift
//  MathMatch
//
//  Created by Gunes Akgun on 30.09.2024.
//

import SwiftUI
import SwiftData

struct ScoresListView: View {
	@Query var scores: [Score]
//	var scores = MockData.sampleScores
	var colorOptions : [Color] =  [
		.orange,
  		.blue,
  		.green
	]
	
	var randomColor : Color {
		return colorOptions.randomElement() ?? .blue
	}
	
    var body: some View {
		if scores.isEmpty {
			Text("No scores registered yet.")
		} else {
			List {
				Section {
					ForEach(Array(scores.enumerated()), id: \.element.id) {
						(index, score) in
						HStack {
							Text(score.playerName)
								.foregroundStyle(.white)
								.frame(maxWidth: .infinity, alignment: .leading)
							Text("\(score.score)")
								.foregroundStyle(.green.gradient)
								.frame(maxWidth: .infinity, alignment: .trailing)
						}
						.listRowBackground(
							Color.blue.opacity(max(0.1, 1.0 - (Double(index) / Double(scores.count))))
						)
					}
				} header: {
					HStack {
						Text("Name")
							.foregroundStyle(.white)
						Spacer()
						Text("Score")
							.foregroundStyle(.green.gradient)
					}
				}
			}
		}
    }
}

#Preview {
	ScoresListView()
}
