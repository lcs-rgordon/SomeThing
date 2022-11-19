//
//  ContentView.swift
//  SomeThing
//
//  Created by Russell Gordon on 2022-11-19.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var board = Board(.easy)
    
    // Track whether game is over
    @State private var isGameOver = false
    
    var body: some View {

        NavigationStack {
            
            VStack {
                Spacer()
                
                Grid(horizontalSpacing: 2, verticalSpacing: 2) {
                    ForEach(0..<board.exampleCells.count, id: \.self) { row in
                        
                        GridRow {
                            let exampleRow = board.exampleCells[row] // what it should be
                            let userRow = board.userCells[row] // what it currently is
                            
                            ForEach(0..<userRow.count, id: \.self) { column in
                                
                                // Is this the currently selected cell?
                                let selected = row == board.selectedRow && column == board.selectedColumn
                                
                                // What will we show or read for the cell view?
                                let userValue = userRow[column] == 0 ? "" : String(userRow[column])
                                
                                CellView(number: userRow[column], isSelected: selected) {
                                    board.selectedRow = row
                                    board.selectedColumn = column
                                }
                                .accessibilityValue(userValue)
                                .accessibilityLabel("Row \(row) column \(column)")
                                .accessibilityAddTraits(selected ? .isSelected : .isButton)
                            }
                            
                            // Show the target number they are working with
                            // Adding a "sum row" after the foreach
                            let exampleSum = sum(forRow: exampleRow)
                            let userSum = sum(forRow: userRow)
                            
                            SumView(number: exampleSum)
                                .foregroundColor(exampleSum == userSum ? .primary : .red)
                                .accessibilityLabel("Row \(row + 1) sum: \(exampleSum)")
                                .accessibilityHint(exampleSum == userSum ? "Correct" : "Incorrect")
                        }
                        
                    }
                    
                    // Show the target number for the column
                    GridRow {
                        ForEach(0..<board.exampleCells[0].count, id: \.self) { column in
                            
                            let exampleSum = sum(forColumn: column, in: board.exampleCells) // what it should be
                            let userSum = sum(forColumn: column, in: board.userCells)
                            
                            SumView(number: exampleSum)
                                .foregroundColor(exampleSum == userSum ? .primary : .red)
                                .accessibilityLabel("Column \(column + 1) sum: \(exampleSum)")
                                .accessibilityHint(exampleSum == userSum ? "Correct" : "Incorrect")

                        }
                    }
                }
                .padding(.horizontal)
                
                Spacer()
                
                HStack {
                    ForEach(1..<10) { i in
                        
                        Button(String(i)) {
                            board.enter(i)
                        }
                        .accessibilityLabel("Enter \(i)")
                        .accessibilityHint(board.hint(for: i))
                        .frame(maxWidth: .infinity)
                        .font(.largeTitle)
                    }
                    
                }
                .padding()
                
                Button("Submit") {
                    isGameOver = true
                }
                .buttonStyle(.borderedProminent)
                .disabled(board.isSolved == false)
                
                Spacer()
            }
            .navigationTitle("SumThing")
            .toolbar {
                Button {
                    isGameOver = true
                } label: {
                    Label("Start a New Game", systemImage: "plus")
                }
            }
            .alert("Start a new game", isPresented: $isGameOver) {
                ForEach(Difficulty.allCases, id: \.self) { difficulty in
                    Button(String(describing: difficulty).capitalized) {
                        startGame(difficulty)
                    }
                }
                Button("Cancel", role: .cancel) { }
            } message: {
                if board.isSolved {
                    Text("You solved the board correctly. Good job! 🎉")
                }
            }
            .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
        }
    }
    
    func sum(forRow row: [Int]) -> Int {
        row.reduce(0, +)
    }
    
    func sum(forColumn column: Int, in cells: [[Int]]) -> Int {
        cells.reduce(0) { $0 + $1[column] }
    }
    
    func startGame(_ difficulty: Difficulty) {
        isGameOver = false
        board.create(difficulty)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
