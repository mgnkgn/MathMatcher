//
//  Item.swift
//  MathMatch
//
//  Created by Gunes Akgun on 26.09.2024.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
