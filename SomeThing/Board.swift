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
    
    init(_ difficulty: Difficulty) {
        create(difficulty)
    }
    
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
        
        // Convert the range to a 2D array of random values
        exampleCells = (0..<size).map { _ in
            (0..<size).map { _ in
                Int.random(in: 1...maxNumber)
            }
            
        }
        
        // Create 2D array for user cells with all zeros
        userCells = Array(repeating: Array(repeating: 0, count: size), count: size)
    }
    
    // Write a number into the selected cell
    func enter(_ number: Int) {
        if userCells[selectedRow][selectedColumn] == number {
            // If the user is already there
            userCells[selectedRow][selectedColumn] = 0
        } else {
            
            userCells[selectedRow][selectedColumn] = number
            
            // If we have a cell to our right, move to the right
            // Otherwise, if there is a row below, move down and go back to column 0
            // Basically makes input faster
            if selectedColumn < exampleCells[0].count - 1 { // if we have space to our right
                selectedColumn += 1
            } else if selectedRow < exampleCells.count - 1 {
                selectedRow += 1
                selectedColumn = 0
            }
            
        }
    }
}
