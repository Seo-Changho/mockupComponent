//
//  tableview.swift
//  mockupComponent
//
//  Created by changho seo on 2/21/24.
//

import SwiftUI

struct tableview: View {
    
    @State var isEditing = false
    @State var itemArray:[String] = ["apple", "banana", "strawberry"]
    @State var itemArray2:[String] = ["graph"]
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Form1")){
                    if itemArray.count != 0 {
                        ForEach(0...itemArray.count-1, id: \.self) { index in
                            HStack{
                                if isEditing {
                                    editView(image: "list_icon_minus", index: index, itemArray: $itemArray, itemArray2: $itemArray2)
                                }
                                Text("\(itemArray[index])")
                                Spacer()
                                if isEditing {
                                    editView(image: "list_ic_menu_edit", itemArray: $itemArray, itemArray2: $itemArray2)
                                }
                            }.id(UUID())
                                .frame(height: 40)
                        }
                        .onMove(perform: move)
                    }
                }
                
                Section(header: Text("Form2")){
                    if itemArray2.count != 0 {
                        ForEach(0...itemArray2.count-1, id: \.self) { index in
                            HStack{
                                if isEditing {
                                    editView(image: "list_icon_plus", index: index, itemArray: $itemArray, itemArray2: $itemArray2)
                                }
                                Text("\(itemArray2[index])")
                            }.frame(height: 40)
                        }
                    }
                }
                
            }
            .toolbar {
                Button(action: {
                    self.isEditing.toggle()
                }) {
                    Text(isEditing ? "Done" : "Edit")
                        .frame(width: 80, height: 40)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }

    func move(from source: IndexSet, to destination: Int){
        itemArray.move(fromOffsets: source, toOffset: destination)
    }
    
}

struct editView: View {
    
    @State var image:String = "list_icon_plus"
    @State var index:Int = 0
    @Binding var itemArray:[String]
    @Binding var itemArray2:[String]
    
    var body: some View {
        ZStack{
            Button(action: {
                actionItem(image, index)
            }, label:{
                Image(image)
                    .foregroundColor(.green)
                    .padding(.leading, 0)
                    .font(.system(size: 22))
            })
        }
        .frame(width: 50)
    }
    
    func actionItem(_ imageString:String, _ index:Int){
        if imageString == "list_icon_minus" {
            self.itemArray2.append(self.itemArray[index])
            self.itemArray.remove(at: index)
        }else if imageString == "list_icon_plus" {
            self.itemArray.append(self.itemArray2[index])
            self.itemArray2.remove(at: index)
        }
    }
}


#Preview {
    tableview()
}
