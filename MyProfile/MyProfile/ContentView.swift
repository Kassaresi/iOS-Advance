//
//  ContentView.swift
//  MyProfile
//
//  Created by Alikhan Kassiman on 2025.02.11.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
            TabView{
                PersonView()
                    .tabItem {
                        Label("Profile",systemImage: "person.circle.fill")
                    }
                HobbyView()
                    .tabItem {
                        Label("Hobby",systemImage: "graduationcap.fill")
                    }
                DreamView()
                    .tabItem {
                        Label("Dream", systemImage: "figure.archery")
                    }
            }
        }
    }


#Preview {
    ContentView()
}
