//
//  HobbyView.swift
//  MyProfile
//
//  Created by Alikhan Kassiman on 2025.02.11.
//

import SwiftUI

struct HobbyView: View {
    let hobbies = [
           ("Vostok", "Football","I play in Vostok team"),
           ("Sleep", "Sleep", "Sometimes I can fall asleep in strange position"),
       ]
       
       var body: some View {
           List(hobbies, id: \.0) { hobby in
               VStack {
                   Image(hobby.0)
                       .resizable()
                       .scaledToFit()
                       .font(.largeTitle)
                       .frame(width: 200, height: 200)
                       .clipped()
                       .clipShape(RoundedRectangle(cornerRadius: 25.0))
                   
                   Text(hobby.1)
                       .font(.headline)
                   Text(hobby.2)
                       .font(.subheadline)
                       .multilineTextAlignment(.center)
                   
               }
               .padding()
               .frame(maxWidth:.infinity, alignment: .center)
           }
           .navigationTitle("Hobbies")
       }
}

#Preview {
    HobbyView()
}
