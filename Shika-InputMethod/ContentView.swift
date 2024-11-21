//
//  ContentView.swift
//  Shika-InputMethod
//
//  Created by 分诺 on 2024/11/21.
//

import SwiftUI

struct ContentView: View {
    @State private var userInput: String = ""
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            TextField("Enter text here", text:$userInput)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Text("You entered: \(userInput)")
                .padding()
        }
        .padding()
        
    }
}

#Preview {
    ContentView()
}
