//
//  BestFriendView.swift
//  Profile
//
//  Created by Alikhan Kassiman on 2025.02.07.
//

import SwiftUI

struct BestFriendView: View {
    var body: some View {
        VStack{
            Image("Beka")
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300)
                .offset(y:-50)
            Text("Bekarys Rymkhanov")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
                .offset(y:-50)
        }
    }
}

#Preview {
    BestFriendView()
}
