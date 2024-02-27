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

struct buttonOption: Identifiable {
    var id = UUID()
    var option:Any?
    var buttonType:buttonType
}

/// popup에 들어갈 컨텐츠 case를 지정하여 확장한다.
enum contentType {
    case title
    case message
    case checkbox
}

/// popup에 들어갈 button case를 지정하여 확장한다.
enum buttonType {
    case okbutton
    case cancelbutton
    case checkbutton
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
    @State var buttonOptions : [buttonOption] = []
    @State private var isOn = false
    
    var isShowVerticalButtons = false
    
    var cancelButtonAction: (() -> ())?
    var okButtonAction: (() -> ())?
    
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
                        ForEach(Array(alertOptions.enumerated()), id: \.offset){ index, option in
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
                                    }
                                }
                                .foregroundColor(Color(red: 52/255,green: 57/255,blue: 68/255))
                                .fixedSize(horizontal: false, vertical: true)
                            }
                        }
                        
                        
                        /// 하단 버튼 영역
                        HStack(spacing: 0) {
                            ForEach(Array(buttonOptions.enumerated()), id: \.offset) { index, button in
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
}

#Preview {
    CustomAlert(presentAlert: .constant(true), alertOptions: [alertOption( option: "메시지입니다.", contentType: .message)], buttonOptions: [buttonOption(buttonType: .okbutton)])
}
