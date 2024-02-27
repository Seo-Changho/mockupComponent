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

enum contentType {
    case title
    case message
}

enum buttonType {
    case onebutton
    case twobutton
    case checkbutton
    
    var rightActionText: String {
        switch self {
        case .onebutton, .twobutton, .checkbutton:
            return "확인"
        }
    }
    
    var leftActionText: String {
        switch self {
        case .twobutton, .checkbutton:
            return "취소"
        default: return ""
        }
    }
}


/**
 CustomAlert를 구성하였습니다.
 
 ZStack으로 앞뒤 배열로 background와 alert창을 구성한다.
 ```swift
 ZStack{ }
 ```
 그 안에 HStack으로 양쪽 margin값을 Spacer()로 줍니다.
 가운데 VStack안에 원하는 컨텐츠를 optionable하게 설정할 수 있도록 합니다.(alertType)
 버튼 스타일을 지정합니다
 
 ```swift
 HStack{ Spacer() VStack() Spacer() }
 ```
 ![customAlert basic](customAlert_basic.png)
 */
struct CustomAlert: View {
    
    /// Flag used to dismiss the alert on the presenting view
    @Binding var presentAlert: Bool
    
    /// The alert type being shown
    @State var alertOptions: [alertOption] = []
    @State var buttonType : buttonType = .onebutton
    
    /// based on this value alert buttons will show vertically
    var isShowVerticalButtons = false
    
    var leftButtonAction: (() -> ())?
    var rightButtonAction: (() -> ())?
    
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
                            }
                            
                        }
                        
                        
                        /// 하단 버튼 영역
                        HStack(spacing: 0) {
                            //left button
                            if (!buttonType.leftActionText.isEmpty) {
                                Button {
                                    leftButtonAction?()
                                } label: {
                                    Text(buttonType.leftActionText)
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
                            }
                            //right button(default)
                            Button {
                                rightButtonAction?()
                            } label: {
                                Text(buttonType.rightActionText)
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
    CustomAlert(presentAlert: .constant(true), alertOptions: [alertOption( option: "메시지입니다.", contentType: .message)], buttonType: .onebutton)
}
