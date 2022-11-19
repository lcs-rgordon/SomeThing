//
//  SumView.swift
//  SomeThing
//
//  Created by Russell Gordon on 2022-11-19.
//

import SwiftUI

struct SumView: View {
    
    @ScaledMetric(relativeTo: .title) var frameWidth = 50 // Stay responsive to dynamic type
    var number: Int
    
    var body: some View {
        Text(String(number))
            .font(.title)
            .monospacedDigit()
            .frame(width: frameWidth, height: frameWidth)
    }
}

struct SumView_Previews: PreviewProvider {
    static var previews: some View {
        SumView(number: 9)
    }
}
