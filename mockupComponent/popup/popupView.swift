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
    @State private var textAlert = false
    @State private var imageAlert = false
    @State private var pickerAlert = false
    @State private var radioAlert = false
    
    @State private var resultString = ""
    
    var body: some View {
        ZStack {
            VStack{
                
                Text(resultString)

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
                    Text("checkButton")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                Button(action: {
                    self.textAlert.toggle()
                }) {
                    Text("textFieldButton")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                Button(action: {
                    self.imageAlert.toggle()
                }) {
                    Text("imageViewButton")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                Button(action: {
                    self.pickerAlert.toggle()
                }) {
                    Text("pickerButton")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                Button(action: {
                    self.radioAlert.toggle()
                }) {
                    Text("radioButton")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            
            if okbuttonAlert {
                CustomAlert(presentAlert: $okbuttonAlert, alertOptions: [alertOption(option: "메시지 입니다.", contentType: .message)], buttonOptions: [alertButtonOption(buttonType: .okbutton)], okButtonAction: {
                    okbuttonAlert.toggle()
                    self.resultString = "success"
                })
            }
            
            if cancelbuttonAlert {
                CustomAlert(presentAlert: $cancelbuttonAlert, alertOptions: [alertOption(option: "타이틀 입니다.", contentType: .title), alertOption(option: "메시지 입니다.", contentType: .message)], buttonOptions: [alertButtonOption(buttonType: .cancelbutton), alertButtonOption(buttonType: .okbutton)], cancelButtonAction: {
                    cancelbuttonAlert.toggle()
                }, okButtonAction: {
                    cancelbuttonAlert.toggle()
                    self.resultString = "success2"
                })
            }
            
            if toggleAlert {
                CustomAlert(presentAlert: $toggleAlert, alertOptions: [alertOption(option: "토글버튼을 선택할 건지에 대한 질문 입니다.", contentType: .message), alertOption(option: "토글버튼 입니다.", contentType: .checkbox)], buttonOptions: [alertButtonOption(buttonType: .cancelbutton), alertButtonOption(buttonType: .checkbutton)], cancelButtonAction: {
                    toggleAlert.toggle()
                }, checkButtonAction: {
                    toggleAlert.toggle()
                    self.resultString = "success3"
                })
            }
            
            if textAlert {
                CustomAlert(presentAlert: $textAlert, alertOptions: [alertOption(option: "placeholder", contentType: .textfield)], buttonOptions: [alertButtonOption(buttonType: .cancelbutton), alertButtonOption(buttonType: .stringbutton)], cancelButtonAction: {
                    textAlert.toggle()
                }, stringButtonAction: { result in
                    textAlert.toggle()
                    self.resultString = result
                })
            }
            
            if imageAlert {
                CustomAlert(presentAlert: $imageAlert, alertOptions: [alertOption(option: "popup_register_processing", contentType: .imageView) ,alertOption(option: "기기 및 서비스와 연결중이며\n1분 이상 걸릴 수 있습니다.", contentType: .message)], buttonOptions: [])
            }
            
            if pickerAlert {
                CustomAlert(presentAlert: $textAlert, alertOptions: [alertOption(option: ["apple", "banana", "cherry", "orange"], contentType: .pickerView)], buttonOptions: [alertButtonOption(buttonType: .cancelbutton), alertButtonOption(buttonType: .stringbutton)], cancelButtonAction: {
                    pickerAlert.toggle()
                }, stringButtonAction: { result in
                    pickerAlert.toggle()
                    self.resultString = result
                })
            }
            
            if radioAlert {
                CustomAlert(presentAlert: $radioAlert, alertOptions: [alertOption(option: "라디오 버튼 리스트 컨트롤", contentType: .message), alertOption(option: ["1", "2", "3"], contentType: .radioView)], buttonOptions: [alertButtonOption(buttonType: .cancelbutton), alertButtonOption(buttonType: .stringbutton)], cancelButtonAction: {
                    radioAlert.toggle()
                }, stringButtonAction: { result in
                    radioAlert.toggle()
                    self.resultString = result
                })
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
}

#Preview {
    popupView()
}
