//
//  textfieldView.swift
//  mockupComponent
//
//  Created by changho seo on 2/28/24.
//

import SwiftUI
import Combine

struct textfieldView: View {
    
    @State private var textString = ""
    
    @State private var nomalBool = false
    @State private var emailBool = false
    @State private var passwordBool = false
    @State private var titleBool = false
    @State private var titlePassBool = false
    @State private var custom = false

    private var combinedBinding: Binding<Bool> {
        Binding<Bool>(
            get: { return nomalBool && emailBool && passwordBool && titleBool && titlePassBool },
            set: { newValue in }
        )
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView{
                VStack {
                    CustomTextField(placeholder: "기본 커스텀 텍스트 입니다.", isSafe: $nomalBool)
                    
                    CustomTextField(placeholder: "이메일 커스텀 텍스트 입니다.", textType: .email, isSafe: $emailBool)
                    
                    CustomTextField(placeholder: "비밀번호 커스텀 텍스트 입니다.", textType: .password, isSafe: $passwordBool)
                    
                    CustomTextField(placeholder: "타이틀포함 커스텀 텍스트 입니다.", textType: .normal, title: "타이틀", isSafe: $titleBool)
                    
                    CustomTextField(placeholder: "타이틀포함 비밀번호 텍스트 입니다.", textType: .password, title: "현재 비밀번호", isSafe: $titlePassBool)
                    
                    CustomTextField(placeholder: "custom", textType: .custom(customTextModel(maxCount: 10, message: "우아아앙", validation:nil)), isSafe: $custom)
                    
                    Spacer()
                    
                    Button(action: { print("success") }) {
                        HStack(alignment: .top, spacing: 10) {
                            Text("확인")
                                .frame(minWidth: 0, maxWidth: geometry.size.width*0.5, minHeight: 50, maxHeight: 50)
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.white)
                                .lineLimit(nil)
                        }
                    }
                    .background(combinedBinding.wrappedValue ? Color(red: 52/255,green: 57/255,blue: 68/255) : .gray.opacity(0.5))
                    .clipShape(.capsule)
                    .disabled(combinedBinding.wrappedValue)
                    
                }
                .padding(16)
            }
            
        }
    }
}

#Preview {
    textfieldView()
}
