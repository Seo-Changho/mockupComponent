//
//  CustomAlert.swift
//  mockupComponent
//
//  Created by changho seo on 2/21/24.
//

import Combine
import SwiftUI

struct alertOption: Identifiable {
    var id = UUID()
    var option:Any
    var contentType:contentType
}

struct alertButtonOption: Identifiable {
    var id = UUID()
    var option:Any?
    var buttonType:buttonType
}

/// popup에 들어갈 컨텐츠 case를 지정하여 확장한다.
enum contentType {
    case title
    case message
    case checkbox
    case textfield
    case imageView
    case pickerView
    case radioView
}

/// popup에 들어갈 button case를 지정하여 확장한다.
enum buttonType {
    case okbutton
    case cancelbutton
    case checkbutton
    case stringbutton
}


/**
 CustomAlert를 구성
 
 ZStack으로 앞뒤 배열로 background와 alert창을 구성한다.
 ```swift
 ZStack{ }
 ```
 alertOption : VStack으로 원하는 컨텐츠를 optionable하게 설정할 수 있도록 합니다
 
 buttonOption : 사용할 버튼의 종류를 선택합니다.
 
 ```swift
 VStack{
 alertOption
 buttonOption
 }
 ```
 ![customAlert basic](customalert_basic.png)
 */
struct CustomAlert: View {
    
    @Binding var presentAlert: Bool
    
    @State var alertOptions: [alertOption] = []
    @State var buttonOptions : [alertButtonOption] = []
    @State private var isOn = false
    @State private var textString : String = ""
    
    @State private var count = 3
    @State private var isCounting = false
    @State private var timer: Timer?
    
    @State private var selectedOption: Int = 0
    
    var isShowVerticalButtons = false
    
    var cancelButtonAction: (() -> ())?
    var okButtonAction: (() -> ())?
    var checkButtonAction: (() -> ())?
    var stringButtonAction: ((String) -> ())?
    
    let verticalButtonsHeight: CGFloat = 80
    
    var body: some View {
        
        GeometryReader { geometry in
            ZStack {
                //faded background
                Color.black.opacity(0.75)
                    .edgesIgnoringSafeArea(.all)
                HStack{
                    Spacer(minLength: 16)
                    VStack(spacing: 0) {
                        ForEach(alertOptions, id: \.id){ option in
                            switch option.contentType {
                            case .title:
                                let value = option.option as? String ?? ""
                                Text(value)
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(Color(red: 52/255,green: 57/255,blue: 68/255))
                                    .multilineTextAlignment(.center)
                                    .padding([.bottom], 16)
                                    .lineLimit(nil)
                                    .fixedSize(horizontal: false, vertical: true)
                            case .message:
                                let value = option.option as? String ?? ""
                                Text(value)
                                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                                    .font(.system(size: 14))
                                    .foregroundColor(Color(red: 52/255,green: 57/255,blue: 68/255))
                                    .multilineTextAlignment(.center)
                                    .lineLimit(nil)
                                    .fixedSize(horizontal: false, vertical: true)
                            case .checkbox:
                                let value = option.option as? String ?? ""
                                Button(action: { self.isOn.toggle() }) {
                                    HStack(alignment: .top, spacing: 10) {
                                        Image(self.isOn ? "checkbox_button_s" : "checkbox_button_n")
                                        Text(value)
                                            .frame(minHeight: 0, maxHeight: .infinity)
                                            .font(.system(size: 14))
                                            .foregroundColor(Color(red: 52/255,green: 57/255,blue: 68/255))
                                            .lineLimit(nil)
                                    }
                                }
                                .padding([.top], 16)
                                .foregroundColor(Color(red: 52/255,green: 57/255,blue: 68/255))
                                .fixedSize(horizontal: false, vertical: true)
                                .buttonStyle(PlainButtonStyle())
                            case .textfield:
                                let value = option.option as? String ?? ""
                                TextField(value, text: $textString)
                                    .padding([.top, .bottom], 10)
                                    .background(Color.white)
                                    .onChange(of: textString) { _ in
                                        self.isOn = textString != ""
                                    }
                                
                                Rectangle()
                                    .frame(height: 2)
                                    .foregroundColor(self.isOn ? Color(red: 52/255,green: 57/255,blue: 68/255) : .gray.opacity(50))
                            case .imageView:
                                let value = option.option as? String ?? ""
                                Image(value)
                                Text("\(count)")
                                    .padding([.bottom], 10)
                                    .onAppear(){
                                        startTimer()
                                    }
                            case .pickerView:
                                let value = option.option as? [String] ?? []
                                Picker("picker view", selection: $textString) {
                                    ForEach(value, id: \.self){ item in
                                        Text(item)
                                    }
                                }
                                .pickerStyle(WheelPickerStyle())
                                .onChange(of: textString) { item in
                                    self.isOn = true
                                    textString = item
                                }
                            case .radioView:
                                let value = option.option as? [String] ?? []
                                ForEach(value.indices, id: \.self){ index in
                                    VStack {
                                        Button(action: {
                                            self.isOn = true
                                            self.selectedOption = index
                                            self.textString = value[index]
                                        }) {
                                            HStack(alignment: .top, spacing: 10) {
                                                Text(value[index])
                                                    .frame(minHeight: 0, maxHeight: .infinity)
                                                    .font(.system(size: 14))
                                                    .foregroundColor(Color(red: 52/255,green: 57/255,blue: 68/255))
                                                    .lineLimit(nil)
                                                Spacer()
                                                Image(self.selectedOption == index ? "radio_button_s" : "radio_button_n")
                                            }
                                        }
                                        .padding([.top], 16)
                                        .foregroundColor(Color(red: 52/255,green: 57/255,blue: 68/255))
                                        .fixedSize(horizontal: false, vertical: true)
                                        .buttonStyle(PlainButtonStyle())
                                    }
                                }
                            }
                        }
                        
                        
                        /// 하단 버튼 영역
                        HStack(spacing: 0) {
                            ForEach(buttonOptions, id: \.id) { button in
                                switch button.buttonType {
                                case .cancelbutton:
                                    Button {
                                        cancelButtonAction?()
                                    } label: {
                                        Text("취소")
                                            .padding()
                                            .frame(minWidth: 0, maxWidth: geometry.size.width*0.5, minHeight: 0, maxHeight: .infinity)
                                            .background(.white)
                                            .font(.system(size: 12, weight: .bold))
                                            .foregroundColor(Color(red: 52/255,green: 57/255,blue: 68/255))
                                            .cornerRadius(30)
                                            .multilineTextAlignment(.center)
                                            .overlay(RoundedRectangle(cornerRadius: 25).stroke(Color(red: 52/255,green: 57/255,blue: 68/255), lineWidth: 1))
                                    }
                                    Spacer(minLength: 8)
                                case .okbutton:
                                    Button {
                                        okButtonAction?()
                                    } label: {
                                        Text("확인")
                                            .padding()
                                            .frame(minWidth: 0, maxWidth: geometry.size.width*0.5, minHeight: 0, maxHeight: .infinity)
                                            .background(Color(red: 52/255,green: 57/255,blue: 68/255))
                                            .font(.system(size: 12, weight: .bold))
                                            .foregroundColor(.white)
                                            .cornerRadius(25)
                                            .multilineTextAlignment(.center)
                                            .overlay(RoundedRectangle(cornerRadius: 25).stroke(Color(red: 52/255,green: 57/255,blue: 68/255), lineWidth: 1))
                                    }
                                case .checkbutton:
                                    Button {
                                        if isOn {checkButtonAction?()}
                                    } label: {
                                        Text("확인")
                                            .padding()
                                            .frame(minWidth: 0, maxWidth: geometry.size.width*0.5, minHeight: 0, maxHeight: .infinity)
                                            .background(isOn ? Color(red: 52/255,green: 57/255,blue: 68/255) : .gray)
                                            .font(.system(size: 12, weight: .bold))
                                            .foregroundColor(.white)
                                            .cornerRadius(25)
                                            .multilineTextAlignment(.center)
                                            .overlay(RoundedRectangle(cornerRadius: 25).stroke(isOn ? Color(red: 52/255,green: 57/255,blue: 68/255) : .gray, lineWidth: 1))
                                    }
                                case .stringbutton:
                                    Button {
                                        if isOn {stringButtonAction?(textString)}
                                    } label: {
                                        Text("확인")
                                            .padding()
                                            .frame(minWidth: 0, maxWidth: geometry.size.width*0.5, minHeight: 0, maxHeight: .infinity)
                                            .background(isOn ? Color(red: 52/255,green: 57/255,blue: 68/255) : .gray)
                                            .font(.system(size: 12, weight: .bold))
                                            .foregroundColor(.white)
                                            .cornerRadius(25)
                                            .multilineTextAlignment(.center)
                                            .overlay(RoundedRectangle(cornerRadius: 25).stroke(isOn ? Color(red: 52/255,green: 57/255,blue: 68/255) : .gray, lineWidth: 1))
                                    }
                                }
                            }
                        }
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 40)
                        .padding([.top], 28)
                    }
                    .padding([.top], 36)
                    .padding([.leading, .trailing], 20)
                    .padding([.bottom], 16)
                    .background(Color.white)
                    .cornerRadius(18)
                    Spacer(minLength: 16)
                }
            }
            .zIndex(2)
        }
    }
    
    func startTimer(){
        count = 3
        isCounting = true
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            count -= 1
            
            if count <= 0 {
                timer.invalidate()
                isCounting = false
                presentAlert = false
            }
        }
    }
}

#Preview {
    CustomAlert(presentAlert: .constant(true), alertOptions: [alertOption( option: "메시지입니다.", contentType: .message)], buttonOptions: [alertButtonOption(buttonType: .okbutton)])
}
