//
//  popupView.swift
//  mockupComponent
//
//  Created by changho seo on 2/21/24.
//

import SwiftUI

struct popupView: View {
    @State private var onebuttonAlert = false
    @State private var twobuttonAlert = false
    
    var body: some View {
        ZStack {
            VStack{
                Button(action: {
                    self.onebuttonAlert.toggle()
                }) {
                    Text("oneButton")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                Button(action: {
                    self.twobuttonAlert.toggle()
                }) {
                    Text("twoButton")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            
            if onebuttonAlert {
                CustomAlert(presentAlert: $onebuttonAlert, alertOptions: [alertOption(option: "메시지 입니다.", contentType: .message)], buttonType: .onebutton, rightButtonAction: {
                    onebuttonAlert.toggle()
                })
            }
            
            if twobuttonAlert {
                CustomAlert(presentAlert: $twobuttonAlert, alertOptions: [alertOption(option: "메시지 입니다.", contentType: .message)], buttonType: .twobutton, leftButtonAction: {
                    twobuttonAlert.toggle()
                }, rightButtonAction: {
                    twobuttonAlert.toggle()
                })
            }
        }
    }
    
}

#Preview {
    popupView()
}
