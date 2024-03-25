//
//  appbar.swift
//  mockupComponent
//
//  Created by changho seo on 3/22/24.
//

import SwiftUI

struct Item: Identifiable {
    var id = UUID()
    var title:String
}

struct appbarView: View {
    var items: [Item] = [
        Item(title: "Apple"),
        Item(title: "Banana"),
        Item(title: "Cherry"),
        Item(title: "Date"),
        Item(title: "Elderberry"),
        Item(title: "Fig"),
        Item(title: "Grape"),
        Item(title: "Honeydew"),
        Item(title: "Iceberg Lettuce")
    ]
    @State private var searchText = ""
    var body: some View {
        ZStack {
            Color(.gray)
            VStack(spacing: 0) {
                customSearchbar(searchText: $searchText)
                ScrollView{
                    VStack(spacing: 0){
                        ForEach(items.filter{$0.title.lowercased().contains(searchText.lowercased())}) { item in
                            Text(item.title)
                                .padding(.leading)
                                .foregroundColor(.white)
                                .frame(height: 60)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color.gray)
                        }
                    }
                    .cornerRadius(10)
                    .shadow(color: .black.opacity(0.5), radius: 10, x: 0, y:0)
                    .padding()
                }
                Spacer()
            }
            .padding(.top, 100)
        }
        .ignoresSafeArea()
    }
    
}

#Preview {
    appbarView()
}
