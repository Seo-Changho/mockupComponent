//
//  ContentView.swift
//  mockupComponent
//
//  Created by changho seo on 2/21/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List{
                NavigationLink(destination: tableview()) {
                    Text("Go to tableView")
                        .padding()
                }
                
                NavigationLink(destination: popupView()) {
                    Text("Go to popupView")
                        .padding()
                }
                
                NavigationLink(destination: tableview()) {
                    Text("Go to tableView")
                        .padding()
                }
                
            }
            .navigationTitle("mockupComponent")
        }
    }
}

#Preview {
    ContentView()
}
