//
//  popupView.swift
//  mockupComponent
//
//  Created by changho seo on 2/21/24.
//

import SwiftUI

struct popupView: View {
    @State private var okbuttonAlert = false
    @State private var cancelbuttonAlert = false
    @State private var toggleAlert = false
    
    var body: some View {
        ZStack {
            VStack{
                Button(action: {
                    self.okbuttonAlert.toggle()
                }) {
                    Text("oneButton")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                Button(action: {
                    self.cancelbuttonAlert.toggle()
                }) {
                    Text("twoButton")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                Button(action: {
                    self.toggleAlert.toggle()
                }) {
                    Text("twoButton")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            
            if okbuttonAlert {
                CustomAlert(presentAlert: $okbuttonAlert, alertOptions: [alertOption(option: "메시지 입니다.", contentType: .message)], buttonOptions: [buttonOption(buttonType: .okbutton)], okButtonAction: {
                    okbuttonAlert.toggle()
                })
            }
            
            if cancelbuttonAlert {
                CustomAlert(presentAlert: $cancelbuttonAlert, alertOptions: [alertOption(option: "타이틀 입니다.", contentType: .title), alertOption(option: "메시지 입니다.", contentType: .message)], buttonOptions: [buttonOption(buttonType: .cancelbutton), buttonOption(buttonType: .okbutton)], cancelButtonAction: {
                    cancelbuttonAlert.toggle()
                }, okButtonAction: {
                    cancelbuttonAlert.toggle()
                })
            }
            
            if toggleAlert {
                CustomAlert(presentAlert: $toggleAlert, alertOptions: [alertOption(option: "토글버튼 입니다.", contentType: .checkbox)], buttonOptions: [buttonOption(buttonType: .cancelbutton), buttonOption(buttonType: .checkbutton)], cancelButtonAction: {
                    toggleAlert.toggle()
                }, okButtonAction: {
                    toggleAlert.toggle()
                })
            }
        }
    }
    
}

#Preview {
    popupView()
}
