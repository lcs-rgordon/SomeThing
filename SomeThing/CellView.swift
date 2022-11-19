//
//  CellView.swift
//  SomeThing
//
//  Created by Russell Gordon on 2022-11-19.
//

import SwiftUI

struct CellView: View {
    
    let number: Int
    let isSelected: Bool
    var onSelected: () -> Void
    
    // Don't show zeros in the cells
    var displayNumber: String {
        if number == 0 {
            return ""
        } else {
            return String(number)
        }
    }
    
    var body: some View {
        // Call on the onSelected closure when tapped
        Button(action: onSelected, label: {
            Text(displayNumber)
                .font(.largeTitle)
                .monospacedDigit()
                .frame(maxWidth: 100, maxHeight: 100)
                .aspectRatio(1, contentMode: .fit)  // stay at a square box the entire time
                .foregroundColor(isSelected ? .white : .primary)
                .background(isSelected ? .blue : .clear)
                .border(.primary.opacity(0.3), width: 1)
                .contentShape(Rectangle()) // whole thing can be tapped anywhere
        })
        .buttonStyle(.plain) // system won't try to colour the button for us
    }
}

struct CellView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CellView(number: 8, isSelected: false, onSelected: {})
            CellView(number: 8, isSelected: true, onSelected: {})
        }
    }
}
