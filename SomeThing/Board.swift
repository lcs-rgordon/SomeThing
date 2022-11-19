//
//  Board.swift
//  SomeThing
//
//  Created by Russell Gordon on 2022-11-19.
//

import Foundation

enum Difficulty: CaseIterable {
    case easy, medium, tricky, taxing, nightmare
}

// 2D array of integers, mostly
class Board: ObservableObject {

    // One is a possible board the user must match
    // Prefilled with a solution for the board
    var exampleCells = [[Int]]()

    // One instance is the layout the user must match
    // This will change as the game is running, @Published ensures the UI updates
    @Published var userCells = [[Int]]()
    
    // Row and column number currently selected
    @Published var selectedRow = 0
    @Published var selectedColumn = 0
    
    func create(_ difficulty: Difficulty) {
        
        // Reset selected cell
        selectedRow = 0
        selectedColumn = 0
        
        let size: Int
        let maxNumber: Int
        
        switch difficulty {
        case .easy:
            size = 2
            maxNumber = 4
        case .medium:
            size = 3
            maxNumber = 4
        case .tricky:
            size = 4
            maxNumber = 4
        case .taxing:
            size = 5
            maxNumber = 6
        case .nightmare:
            size = 5
            maxNumber = 8
        }
        
        // some more code to come
    }
}
