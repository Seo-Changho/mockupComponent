//
//  mockupComponentApp.swift
//  mockupComponent
//
//  Created by changho seo on 2/21/24.
//

import SwiftUI

@main
struct mockupComponentApp: App {

    private var backButtonAppearance: UIBarButtonItemAppearance {
        let backButtonAppearance = UIBarButtonItemAppearance()
        // backButton에 표출되는 text color및 사이즈 조정
        backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.black, .font: UIFont.systemFont(ofSize: 20)]

        return backButtonAppearance
    }
    
    init(){
        
        // navigationbar의 배경에 대한 정의
        // navigationbar의 backbutton에 대한 전역 변경
        
        let appearance = UINavigationBarAppearance()
        let backImage = UIImage(named: "list_ic_light_on")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        
        appearance.setBackIndicatorImage(backImage, transitionMaskImage: backImage)
        appearance.backgroundColor = UIColor.orange
        appearance.backButtonAppearance = backButtonAppearance
        
//        appearance.largeTitleTextAttributes = [.foregroundColor:UIColor.black]
//        appearance.titleTextAttributes = [.foregroundColor:UIColor.white, .font:UIFont.boldSystemFont(ofSize: 20)]
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    @StateObject var appState = AppState()
    var body: some Scene {
        
        WindowGroup {
            ZStack{
                ContentView()
                
                if appState.isLoading {
                    progressView()
                }
            }
            .environmentObject(appState)
        }
    }
}

class AppState: ObservableObject {
    @Published var isLoading: Bool = false
}
