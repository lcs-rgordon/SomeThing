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
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
