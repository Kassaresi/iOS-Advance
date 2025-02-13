//
//  PersonView.swift
//  MyProfile
//
//  Created by Alikhan Kassiman on 2025.02.11.
//

import SwiftUI
let name = "Alikhan"
let surname = "Kassiman"
let age = "20 year old"
let school = "Oskemen KTL"

struct PersonView: View {
    var body: some View {
        VStack{
            Image("Portret")
                .resizable()
                .scaledToFit()
                .frame(width: 200)
                .clipShape(Circle())
                .shadow(radius: 10)
                
                
            
            Text(name)
                .font(.title)
                .fontWeight(.bold)
               
            
            Text(age)
                .font(.headline)
               
            Text(school)
                .font(.subheadline)
            
        }
        .padding()
        .offset(y:-100)
    }
}

#Preview {
    PersonView()
}
