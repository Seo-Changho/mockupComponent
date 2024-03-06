//
//  tabbarView.swift
//  mockupComponent
//
//  Created by changho seo on 3/5/24.
//

import SwiftUI

struct tabbarView: View {
    var body: some View {
        TabView {
            VStack{
                Text("aaa")
                Text("aaa1")
            }
            .tabItem{
                Image(systemName: "1.square.fill")
                Text("First")
            }
            .badge(2)
            
            VStack{
                Text("bbb")
                Text("bbb2")
            }
            .tabItem{
                Image(systemName: "2.square.fill")
                Text("Second")
            }
            VStack{
                Text("ccc")
                Text("ccc3")
            }
            .tabItem{
                Image(systemName: "3.square.fill")
                Text("Third")
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    tabbarView()
}
