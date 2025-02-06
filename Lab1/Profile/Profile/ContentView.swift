//
//  ContentView.swift
//  Profile
//
//  Created by Alikhan Kassiman on 2025.02.06.
//

import SwiftUI
let name = "Alikhan Kassiman"

struct ContentView: View {
    var body: some View {
        NavigationView{
            VStack(spacing:20){
                Image("Photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                    .offset(y:-50)
                
                Text(name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                    .offset(y:-50)
                Text("20 yers old")
                    .padding()
                    .offset(y:-50)
                
                NavigationLink(destination: BestFriendView()) {
                    Text("Best Friend")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
