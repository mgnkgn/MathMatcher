//
//  OperationPreview.swift
//  MathMatch
//
//  Created by Gunes Akgun on 27.09.2024.
//

import SwiftUI

struct OperationPreview: View {
	@EnvironmentObject var gameManager: GameManager
	
	var body: some View {
		VStack {
			if gameManager.selectedTiles.isEmpty {
				Text("Select tiles to perform operation")
					.foregroundColor(.gray)
			} else {
				ScrollViewReader { scrollProxy in
					ScrollView(.horizontal, showsIndicators: false){
						HStack {
							
							Text(getOperationSymbol(for: gameManager.activeOperation))
								.font(.subheadline)
								
							
							ForEach(0..<gameManager.selectedTiles.count, id: \.self) { index in
								let tile = gameManager.selectedTiles[index]
								Text("\(tile.value)")
									.font(.subheadline)
									.padding(1)
								
								if index < gameManager.selectedTiles.count - 1 {
									Text(getOperationSymbol(for: gameManager.activeOperation))
										.font(.subheadline)
										
								}
							}
							
							
							if gameManager.selectedTiles.count > 1 {
								Text("=")
									.font(.subheadline)
									.padding(1)
								
								Text("\(calculatePreviewResult())")
									.font(.subheadline)
									.padding(1)
							}
						}
					}
					.padding(.vertical)
					.onChange(of: gameManager.selectedTiles) { oldValue, newValue in
						withAnimation{
							let lastIndex = gameManager.selectedTiles.count - 1
							scrollProxy.scrollTo(lastIndex, anchor: .trailing)
						}
					}
				}
				
			}
		}
	}
	

	func getOperationSymbol(for operation: GameManager.MathOperation) -> String {
		switch operation {
		case .addition:
			return "+"
		case .subtraction:
			return "-"
		case .multiplication:
			return "×"
		case .division:
			return "÷"
		}
	}
	
	func calculatePreviewResult() -> Int {
		var result: Int =  0
		
		for tile in gameManager.selectedTiles {
			switch gameManager.activeOperation {
			case .addition:
				result += tile.value
			case .subtraction:
				result -= tile.value
			case .multiplication:
				result *= tile.value
			case .division:
				if tile.value != 0 {
					result /= tile.value
				}
			}
		}
		
		return result
	}
}

#Preview {
	OperationPreview()
		.environmentObject(GameManager())
}
