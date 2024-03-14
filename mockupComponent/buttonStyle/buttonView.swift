//
//  buttonView.swift
//  mockupComponent
//
//  Created by changho seo on 3/4/24.
//

import SwiftUI


struct buttonView: View {
    
    @State var tag:Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack{
                    Text("case: ok, cancel, remove, image")
                        .padding([.bottom], 10)
                    
                    HStack {
                        
                        NavigationLink("gogo", value: 1)
                        
                        CustomButton(buttonStyle: .ok("확인"), buttonState: .enable, okButtonAction: {
                            self.tag = true
                            print("확인 :: ")
                        })
                        
                        CustomButton(buttonStyle: .cancel("취소"), buttonState: .enable, cancelButtonAction: {
                            print("취소 :: ")
                        })
                        CustomButton(buttonStyle: .remove("삭제"), buttonState: .enable, removeButtonAction: {
                            print("삭제 :: ")
                        })
                        CustomButton(buttonStyle: .image("list_icon_plus"), buttonState: .enable, imageButtonAction: {
                            print("iamge :: ")
                        })
                    }
                    .padding([.bottom], 20)
                    
                    Text("case: 갯수에 따른 width")
                        .padding([.bottom], 10)
                    HStack{
                        CustomButton(buttonStyle: .ok("확인"), buttonState: .enable, okButtonAction: {
                            print("확인 :: ")
                        })
                        CustomButton(buttonStyle: .cancel("취소"), buttonState: .enable, cancelButtonAction: {
                            print("취소 :: ")
                        })
                    }
                    .padding([.bottom], 20)
                    
                    Text("case: disable option에 따른 상태")
                        .padding([.bottom], 10)
                    VStack {
                        CustomButton(buttonStyle: .ok("확인"), buttonState: .disable, okButtonAction: {
                            print("확인 :: ")
                        })
                        
                        CustomButton(buttonStyle: .cancel("취소"), buttonState: .disable, cancelButtonAction: {
                            print("취소 :: ")
                        })
                        
                        CustomButton(buttonStyle: .remove("삭제"), buttonState: .disable, removeButtonAction: {
                            print("삭제 :: ")
                        })
                        
                        CustomButton(buttonStyle: .image("list_icon_plus"), buttonState: .disable, imageButtonAction: {
                            print("iamge :: ")
                        })
                    }
                    .padding([.bottom], 20)
                    
                    Text("case: circle")
                        .padding([.bottom], 10)
                    VStack{
                        CustomButton(buttonStyle: .circle("list_icon_plus"), buttonState: .enable, circleButtonAction: {
                            print("circle ::")
                        })
                        CustomButton(buttonStyle: .circle("list_icon_plus"), buttonState: .disable, circleButtonAction: {
                            print("circle ::")
                        })
                    }
                    .padding([.bottom], 20)
                    
                    Text("case: custom")
                        .padding([.bottom], 10)
                    VStack{
                        CustomButton(buttonStyle: .custom(customStyleModel(title: "커스텀", imgSrc: "list_icon_plus", textColor: .white, backgroundColor: Color(red: 100/255,green: 200/255,blue: 200/255), isTextImage: true, maxWidth: 150)), buttonState: .enable, customButtonAction: {
                            print("custom ::")
                        })
                        CustomButton(buttonStyle: .custom(customStyleModel(title: "커스텀", imgSrc: "list_icon_plus", textColor: .white, backgroundColor: Color(red: 100/255,green: 200/255,blue: 200/255), isTextImage: false, maxWidth: 100)), buttonState: .disable, customButtonAction: {
                            print("custom ::")
                        })
                        CustomButton(buttonStyle: .custom(customStyleModel(title: "", imgSrc: "list_icon_plus", textColor: .white, backgroundColor: Color(red: 100/255,green: 200/255,blue: 200/255), isTextImage: false, maxWidth: 250)), buttonState: .enable, customButtonAction: {
                            print("custom ::")
                        })
                        
                        CustomButton(buttonStyle: .custom(customStyleModel(title: "커스텀", imgSrc: "", textColor: .white, backgroundColor: Color(red: 150/255,green: 100/255,blue: 100/255), isTextImage: false, maxWidth: 300)), buttonState: .enable, customButtonAction: {
                            print("custom ::")
                        })
                    }
                }
                .padding(16)
            }
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}

#Preview {
    buttonView()
}
