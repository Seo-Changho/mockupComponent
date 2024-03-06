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
                
                NavigationLink(destination: textfieldView()) {
                    Text("Go to textfieldView")
                        .padding()
                }
                
                NavigationLink(destination: buttonView()) {
                    Text("Go to button")
                        .padding()
                }
                
                NavigationLink(destination: tabbarView()) {
                    Text("Go to tabbarView")
                        .padding()
                }
                
                NavigationLink(destination: actionSheetView()) {
                    Text("Go to actionSheetView")
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
