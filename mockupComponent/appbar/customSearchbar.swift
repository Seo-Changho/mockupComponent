//
//  SwiftUIView.swift
//  mockupComponent
//
//  Created by changho seo on 3/22/24.
//

import SwiftUI

struct customSearchbar: View {
    
    @Binding var searchText:String
    @State var iconOffset = false
    @State var state = false
    @State var progress:CGFloat = 1.0
    @State var showTextFi = false
    var body: some View {
        ZStack(alignment: .trailing){
            ZStack {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .stroke(lineWidth: 3)
                    .foregroundColor(Color.gray)
                if showTextFi {
                    TextField("Search...", text: $searchText)
                        .padding(.horizontal)
                        .foregroundColor(.white)
                }
            }
            .frame(width: state ? 350 : 50, height: 50)
            .foregroundColor(Color.black)
            
            icon(searchText: $searchText, progress: $progress, iconOffset: $iconOffset, state: $state, showTextFi: $showTextFi)
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
}

struct icon: View {
    @Binding var searchText : String
    @Binding var progress : CGFloat
    @Binding var iconOffset: Bool
    @Binding var state: Bool
    @Binding var showTextFi : Bool
    var body: some View {
        Button {
            if showTextFi {
               showTextFi = false
                searchText = ""
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation {
                    if !showTextFi && state {
                        showTextFi = true
                    }
                }
            }
            withAnimation{
                state.toggle()
            }
            if progress == 1.0{
                withAnimation(.linear(duration: 0.5)){
                    progress = 0.0
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    withAnimation{
                        iconOffset.toggle()
                    }
                }
            }else{
                withAnimation{
                    iconOffset.toggle()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    withAnimation(.linear(duration: 0.5)){
                        progress = 1.0
                    }
                }
            }
        } label: {
            VStack(spacing: 0) {
                Circle()
                    .trim(from: 0.0, to: progress)
                    .stroke(lineWidth: 3)
                    .rotationEffect(.degrees(88))
                    .frame(width: 15, height: 15)
                    .padding()
                RoundedRectangle(cornerRadius: 5)
                    .frame(width: 3, height: iconOffset ? 20 : 15)
                    .offset(y: -17)
                    .overlay{
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: 3, height: iconOffset ? 20 : 15)
                            .rotationEffect(.degrees(iconOffset ? 80 : 0), anchor: .center)
                            .offset(y: -17)
                    }
            }
        }
        .rotationEffect(.degrees(-40))
        .offset(x: iconOffset ? -5 : -3, y: iconOffset ? -5 : 2)
        .foregroundColor(.white)
        .frame(width: 40, height: 40)
    }
}

#Preview {
    customSearchbar(searchText: .constant(""))
}
