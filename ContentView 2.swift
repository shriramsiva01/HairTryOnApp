//
//  ContentView 2.swift
//  ARHairTryOn
//
//  Created by shriram siva on 22/02/25.
//


import SwiftUI

struct ContentView: View {
    let hairstyles = ["hairstyle1", "hairstyle2", "hairstyle3"]
    
    @State private var selectedHairstyle = "hairstyle1"
    
    var body: some View {
        VStack {
            ARViewContainer(selectedHairstyle: $selectedHairstyle) // Pass selected hairstyle to ARView
            
            HStack {
                ForEach(hairstyles, id: \.self) { style in
                    Button(action: {
                        selectedHairstyle = style  // Update selected hairstyle
                    }) {
                        Text(style.capitalized)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            }
            .padding()
        }
    }
}
