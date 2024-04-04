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

protocol textType{
    func validation()
    func getMaxCount() -> Int32
    func getMessage() -> String
    func getRegularExpression() -> String
}

struct normal:textType {
    func validation(){
        print("nomal ::")
    }
    
    func getMaxCount() -> Int32 {
        return 0
    }
    
    func getMessage() -> String {
        return ""
    }
    
    func getRegularExpression() -> String {
        return ".*"
    }
}

struct email:textType {
    func validation(){
        print("email ::")
    }
    
    func getMaxCount() -> Int32 {
        return 100
    }
    
    func getMessage() -> String {
        return "이메일 체크가 필요합니다."
    }
    
    func getRegularExpression() -> String {
        return "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    }
}

struct password:textType {
    func validation(){
        print("password ::")
    }
    
    func getMaxCount() -> Int32 {
        return 16
    }
    
    func getMessage() -> String {
        return "패스워드 형식에 올바르지 않습니다."
    }
    
    func getRegularExpression() -> String {
        return 
            """
            ^(?=.*[A-Za-z])(?=.*\\d)(?=.*[`~!@#$%^&*()_|+\\-=?;:'",.<>\\{\\}\\[\\]\\\\/])[`~!@#$%^&*()_|+\\-=?;:'",.<>\\{\\}\\[\\]\\\\/\\w]{8,16}$
            """
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
    @State var textType:textType = normal()
    @State var isSecret:Bool = false
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
        
        if isSecret {
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
        
        guard validationCount(text: text, count: type.getMaxCount()) else{
            return validation(isSafe: false, unsafeMessage: "1-\(type.getMaxCount())자 까지 입력이 가능합니다.")
        }
        
        let safe = regularExpression(text: text, type: type)
        return validation(isSafe: safe, unsafeMessage: type.getMessage())
    }
    
    func regularExpression(text:String, type:textType) -> Bool {
        return NSPredicate(format:"SELF MATCHES %@", type.getRegularExpression()).evaluate(with: text)
    }
    
    func validationCount(text:String, count:Int32) -> Bool{
        return count == 0 ? true : text.count < count
    }
    
}

#Preview {
    CustomTextField(placeholder: "custom", isSafe: .constant(true))
}
