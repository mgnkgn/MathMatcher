//
//  GameGridView.swift
//  MathMatch
//
//  Created by Gunes Akgun on 26.09.2024.
//

import SwiftUI

struct GameGridView: View {
    @EnvironmentObject var gameManager: GameManager
    
    var body: some View {
        VStack {
            // Ensure the grid is populated
            if gameManager.grid.isEmpty {
                Text(
                    "Loading..."
                )
            } else {
                // Displaying the grid of numbers
                LazyVGrid(
                    columns: Array(
                        repeating: GridItem(
                            .fixed(
                                35
                            )
                        ),
                        count: gameManager.columns
                    )
                ) {
                    ForEach(
                        0..<gameManager.rows,
                        id: \.self
                    ) { row in
                        ForEach(
                            0..<gameManager.columns,
                            id: \.self
                        ) { col in
                            let tile = gameManager.grid[row][col]
                            TileView(
                                tile: tile
                            )
                            .id(tile.id)
                            
                        }
                    }
                }
            }
		}
    }
}

struct TileView: View {
    var tile: Tile
    @EnvironmentObject var gameManager: GameManager
	@State var isSelected = false
    
    
    var body: some View {
        Text(
            "\(tile.value)"
        )
        .frame(
            width: 40,
            height: 40
        )
        .background(
            isSelected ? tile.color.opacity(0.4) : tile.color
        )
        .foregroundColor(
            .white
        )
        .cornerRadius(
            8
        )
        .onTapGesture {
            gameManager.selectTile(tile: tile)
			isSelected.toggle()
        }
        .shadow(color: tile.color, radius: 7)
    }
}

#Preview {
    GameGridView()
}
