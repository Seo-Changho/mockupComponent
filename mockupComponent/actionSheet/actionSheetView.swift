//
//  actionSheetView.swift
//  mockupComponent
//
//  Created by changho seo on 3/5/24.
//

import SwiftUI

struct actionSheetView: View {
    
    @State var showingSheet = false
    
    var body: some View {
        VStack {
            ShareLink(item: URL(string: "https://www.naver.com")!) {
                Label("Share", systemImage: "square.and.arrow.up")
            }
            .padding(20)
            
            
            Button(action: {
                self.showingSheet = true
            }) {
                Text("Action Sheet")
            }
            .confirmationDialog("Title", isPresented: $showingSheet) {
                Button("추가", role: .none) {
                    print("추가 ::")
                }
                Button("제거", role: .destructive) {
                    print("제거 ::")
                }
                Button("취소", role: .cancel) {
                    print("취소 ::")
                }
            }
            .padding(20)
            
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    actionSheetView()
}
