//
//  ContentView.swift
//  SomeThing
//
//  Created by Russell Gordon on 2022-11-19.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var board = Board(.medium)
    
    var body: some View {

        NavigationStack {
            
            VStack {
                Spacer()
                
                Grid(horizontalSpacing: 2, verticalSpacing: 2) {
                    ForEach(0..<board.exampleCells.count, id: \.self) { row in
                        
                        GridRow {
                            let userRow = board.userCells[row]
                            
                            ForEach(0..<userRow.count, id: \.self) { column in
                                
                                // Is this the currently selected cell?
                                let selected = row == board.selectedRow && column == board.selectedColumn
                                
                                CellView(number: userRow[column], isSelected: selected) {
                                    board.selectedRow = row
                                    board.selectedColumn = column
                                }
                            }
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
                        .frame(maxWidth: .infinity)
                        .font(.largeTitle)
                    }
                    
                }
                .padding()
            }
            .navigationTitle("SumThing")
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
