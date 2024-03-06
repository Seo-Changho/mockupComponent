//
//  CustomTextField.swift
//  mockupComponent
//
//  Created by changho seo on 2/28/24.
//

import SwiftUI

struct customTextModel:Equatable {
    let maxCount:Int32?
    let message:String?
    let validation:String?
}

enum textType:Equatable {
    
    case normal
    case email
    case password
    case custom(customTextModel)
    
    var getmaxCount:Int32 {
        switch self {
        case .normal:
            return 0
        case .email:
            return 100
        case .password:
            return 16
        case .custom(let item):
            return item.maxCount ?? 0
        }
    }
    
    var getMessage:String{
        switch self {
        case .normal:
            return ""
        case .email:
            return "이메일 체크가 필요합니다."
        case .password:
            return "패스워드 형식에 올바르지 않습니다."
        case .custom(let item):
            return item.message ?? ""
        }
    }
    
    var getRegularExpression:String{
        switch self{
        case .normal:
            return ".*"
        case .email:
            return "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        case .password:
            return 
                """
                ^(?=.*[A-Za-z])(?=.*\\d)(?=.*[`~!@#$%^&*()_|+\\-=?;:'",.<>\\{\\}\\[\\]\\\\/])[`~!@#$%^&*()_|+\\-=?;:'",.<>\\{\\}\\[\\]\\\\/\\w]{8,16}$
                """
        case .custom(let item):
            return item.validation ?? ".*"
        }
    }
}

struct validation {
    var isSafe:Bool
    var unsafeMessage:String
}


/**
 CustomTextField를 구성
 
 ```
 ```
 
 */
struct CustomTextField: View {
    
    @State var placeholder = "placeholder"
    @State var textType:textType = .normal
    @State var title = ""
    @Binding var isSafe:Bool
    @State private var textfieldString = ""
    @State private var message = ""
    
    var body: some View {
        
        if title != "" {
            Text(title)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .padding([.bottom], 5)
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(Color(red: 52/255,green: 57/255,blue: 68/255))
        }
        
        if textType == .password {
            SecureField(placeholder, text: $textfieldString)
                .padding([.top, .bottom], 2)
                .background(Color.white)
                .onAppear{
                    UITextField.appearance().clearButtonMode = .whileEditing
                }
                .onChange(of: textfieldString) { text in
                    let result = validationCheck(text:text, type: textType)
                    isSafe = result.isSafe
                    message = textfieldString.isEmpty ? "" : self.isSafe ? "" : result.unsafeMessage
                }
        }else{
            TextField(placeholder, text: $textfieldString)
                .padding([.top, .bottom], 2)
                .background(Color.white)
                .onAppear{
                    UITextField.appearance().clearButtonMode = .whileEditing
                }
                .onChange(of: textfieldString) { text in
                    let result = validationCheck(text:text, type: textType)
                    isSafe = result.isSafe
                    message = textfieldString.isEmpty ? "" : self.isSafe ? "" : result.unsafeMessage
                }
        }
        
        Rectangle()
            .frame(height: 2)
            .foregroundColor(textfieldString.isEmpty ? .gray.opacity(50) : self.isSafe ? Color(red: 52/255,green: 57/255,blue: 68/255) : Color(red: 254/255,green: 72/255,blue: 113/255))
        
        Text(message)
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            .font(.system(size: 14))
            .foregroundColor(Color(red: 254/255,green: 72/255,blue: 113/255))
    }
    
    
    
    func validationCheck(text:String, type:textType) -> validation {
        
        guard validationCount(text: text, count: type.getmaxCount) else{
            return validation(isSafe: false, unsafeMessage: "1-\(type.getmaxCount)자 까지 입력이 가능합니다.")
        }
        
        let safe = regularExpression(text: text, type: type)
        return validation(isSafe: safe, unsafeMessage: type.getMessage)
    }
    
    func regularExpression(text:String, type:textType) -> Bool {
        return NSPredicate(format:"SELF MATCHES %@", type.getRegularExpression).evaluate(with: text)
    }
    
    func validationCount(text:String, count:Int32) -> Bool{
        return count == 0 ? true : text.count < count
    }
    
}

#Preview {
    CustomTextField(placeholder: "custom", isSafe: .constant(true))
}
