//
//  DreamView.swift
//  MyProfile
//
//  Created by Alikhan Kassiman on 2025.02.11.
//

import SwiftUI
let dream = "Main dream"
let plan = [
    ("1)","Find good job"),
    ("2)","Find girlfriend"),
    ("3)","Make mirrage")
]

struct DreamView: View {
    var body: some View {
        VStack{
            Spacer(minLength: 20)
            Text (dream)
                .font(.title)
                .fontWeight(.bold)
            Spacer(minLength: 20)
            
            Image("Goal")
                .resizable()
                .scaledToFit()
                .frame(width: 300)
                .clipShape(RoundedRectangle(cornerRadius: 25.0))
                
            
            List(plan, id:\.0) { goal in
                HStack{
                    Text(goal.0)
                        .font(.headline)
                    
                    Text(goal.1)
                        .font(.headline)
                }
                
            }
        }
      }
}

#Preview {
    DreamView()
}
