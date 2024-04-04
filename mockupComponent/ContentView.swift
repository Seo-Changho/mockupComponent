//
//  ContentView.swift
//  mockupComponent
//
//  Created by changho seo on 2/21/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.scenePhase) var phase
    @State private var isEditing:Bool = false
    @State private var presentedMusic = NavigationPath()
    @State private var searchText = ""
    @EnvironmentObject var appState: AppState
    
    var body: some View {

        NavigationStack(path: $presentedMusic) {
            List{
                NavigationLink("Go to tableView", value: "1")
                    .padding()
                NavigationLink("Go to popupView", value: "2")
                    .padding()
                NavigationLink("Go to textfieldView", value: "3")
                    .padding()
                NavigationLink("Go to buttonView", value: "4")
                    .padding()
                NavigationLink("Go to tabbarView", value: "5")
                    .padding()
                NavigationLink("Go to actionSheetView", value: "6")
                    .padding()
                NavigationLink("Go to appbarView", value: "7")
                    .padding()
                NavigationLink("Go to customSearchbar", value: "8")
                    .padding()
                NavigationLink("Go to onethings", value: "9")
                    .padding()
            }
            .navigationTitle("mockupComponent")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchText)
            .toolbar {
                ToolbarItem(placement: .topBarLeading){
                    Button(action: {
                        print("button action ::")
                    }){
                        Image(systemName: "swift")
                    }
                }
                ToolbarItem(placement: .topBarTrailing){
                    Button(action: {
                        appState.isLoading.toggle()
                    }){
                        Text("progress")
                    }
                }
            }
            .navigationDestination(for: String.self){ value in
                switch value{
                case "1" : tableview()
                case "2" : popupView()
                case "3" : textfieldView()
                case "4" : buttonView()
                case "5" : tabbarView()
                case "6" : actionSheetView()
                case "7" : appbarView()
                case "8" : customSearchbar(searchText: .constant(""))
                case "9" : oneThing()
                default : tableview()
                }
            }
            .navigationDestination(for: Int.self){ value in
                switch value{
                case 1: actionSheetView()
                default: actionSheetView()
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(){
            print("main onAppear ::")
        }
        .onDisappear(){
            print("main onDisappear ::")
        }
        .onChange(of: phase){ newValue in
            switch newValue {
            case .background:
                print("background ::")
            case .inactive:
                print("inactive ::")
            case .active:
                print("active ::")
            @unknown default:
                print("")
            }
        }
    }
}

#Preview {
    ContentView()
}

