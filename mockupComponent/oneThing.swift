//
//  oneThing.swift
//  mockupComponent
//
//  Created by changho seo on 3/29/24.
//

import SwiftUI

struct oneThing: View {
    @State private var fruit:String = "banana"
    @State private var custom = false
    
    var body: some View {
        Spacer()
        
        Text(fruit)
        Spacer()
        
        Button(action: {
            fruit = "strawberry"
        }) {
            Text("과일변경")
        }
        .padding(20)
        Spacer()
    }
}

#Preview {
    oneThing()
}
