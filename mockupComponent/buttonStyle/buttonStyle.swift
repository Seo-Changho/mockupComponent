//
//  buttonStyle.swift
//  mockupComponent
//
//  Created by changho seo on 3/4/24.
//

import SwiftUI


struct customStyleModel:Equatable {
    let title:String?
    let imgSrc:String?
    let textColor:Color?
    let backgroundColor:Color?
    let isTextImage:Bool?
    let maxWidth:CGFloat?
}

enum buttonStyleCase {
    case ok(String)
    case cancel(String)
    case remove(String)
    case image(String)
    case circle(String)
    case custom(customStyleModel)
}

enum buttonState {
    case disable
    case enable
    case error
}

struct CustomButton: View {
    
    @State var buttonStyle:buttonStyleCase = .ok("확인")
    @State var buttonState:buttonState = .enable
    
    var okButtonAction: (() -> ())?
    var cancelButtonAction: (() -> ())?
    var removeButtonAction: (() -> ())?
    var imageButtonAction: (() -> ())?
    var circleButtonAction: (() -> ())?
    var imageTextButtonAction: (() -> ())?
    var customButtonAction: (() -> ())?
    
    var body: some View {
        switch buttonStyle {
        case .ok(let item):
            Button(action: { 
                okButtonAction?()
            }) {
                HStack(alignment: .top, spacing: 10) {
                    Text(item)
                        .frame(minWidth: 0, maxWidth: 200, minHeight: 50, maxHeight: 50)
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                        .lineLimit(nil)
                }
            }
            .background(buttonState == .disable ? .gray.opacity(0.5) : Color(red: 52/255,green: 57/255,blue: 68/255))
            .clipShape(.capsule)
            .disabled(buttonState == .disable)
            .overlay(
                Capsule(style: .continuous)
                    .stroke(buttonState == .disable ? .gray.opacity(0.5) : Color(red: 52/255,green: 57/255,blue: 68/255), style: StrokeStyle(lineWidth: 1))
            )
            
        case .cancel(let item):
            Button(action: {
                cancelButtonAction?()
            }) {
                HStack(alignment: .top, spacing: 10) {
                    Text(item)
                        .frame(minWidth: 0, maxWidth: 200, minHeight: 50, maxHeight: 50)
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(buttonState == .disable ? .gray.opacity(0.5) : Color(red: 52/255,green: 57/255,blue: 68/255))
                        .lineLimit(nil)
                }
            }
            .background(Color.white)
            .disabled(buttonState == .disable)
            .overlay(
                Capsule(style: .continuous)
                    .stroke(buttonState == .disable ? .gray.opacity(0.5) : Color(red: 52/255,green: 57/255,blue: 68/255), style: StrokeStyle(lineWidth: 1))
            )
            
        case .remove(let item):
            Button(action: {
                removeButtonAction?()
            }) {
                HStack(alignment: .top, spacing: 10) {
                    Text(item)
                        .frame(minWidth: 0, maxWidth: 200, minHeight: 50, maxHeight: 50)
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                        .lineLimit(nil)
                }
            }
            .background(buttonState == .disable ? Color(red: 254/255,green: 72/255,blue: 113/255).opacity(0.5) : Color(red: 254/255,green: 72/255,blue: 113/255))
            .clipShape(.capsule)
            .disabled(buttonState == .disable)
            .overlay(
                Capsule(style: .continuous)
                    .stroke(buttonState == .disable ? Color(red: 254/255,green: 72/255,blue: 113/255).opacity(0.5) : Color(red: 254/255,green: 72/255,blue: 113/255), style: StrokeStyle(lineWidth: 1))
            )
        case .image(let item):
            Button(action: {
                imageButtonAction?()
            }) {
                Image(item)
                    .frame(minWidth: 0, maxWidth: 200, minHeight: 50, maxHeight: 50)
            }
            .clipShape(.capsule)
            .disabled(buttonState == .disable)
            .overlay(
                Capsule(style: .continuous)
                    .stroke(buttonState == .disable ? .gray.opacity(0.5) : Color(red: 52/255,green: 57/255,blue: 68/255), style: StrokeStyle(lineWidth: 1))
            )
        case .circle(let item):
            Button(action: {
                circleButtonAction?()
            }) {
                Image(item)
                    .frame(minWidth: 0, maxWidth: 200, minHeight: 50, maxHeight: 50)
                    .disabled(buttonState == .disable)
                    .opacity(buttonState == .disable ? 0.5 : 1)
            }
            .clipShape(.circle)
            .background(Color.white)
            .disabled(buttonState == .disable)
            .overlay(
                Circle()
                    .stroke(buttonState == .disable ? .gray.opacity(0.5) : Color(red: 52/255,green: 57/255,blue: 68/255), style: StrokeStyle(lineWidth: 1))
            )
        case .custom(let item):
            Button(action: {
                customButtonAction?()
            }) {
                HStack(alignment: .top, spacing: 10) {
                    if item.title == ""{
                        Image(item.imgSrc ?? "")
                    }else if item.imgSrc == "" {
                        Text(item.title ?? "")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.white)
                            .lineLimit(nil)
                    }else if item.isTextImage ?? false {
                        Image(item.imgSrc ?? "")
                        Text(item.title ?? "")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.white)
                            .lineLimit(nil)
                    }else{
                        Text(item.title ?? "")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.white)
                            .lineLimit(nil)
                        Image(item.imgSrc ?? "")
                    }
                }
                .frame(minWidth: 0, maxWidth: item.maxWidth, minHeight: 50, maxHeight: 50)
            }
            .background(buttonState == .disable ? .gray.opacity(0.5) : item.backgroundColor)
            .clipShape(.capsule)
            .disabled(buttonState == .disable)
            .overlay(
                Capsule(style: .continuous)
                    .stroke((buttonState == .disable ? .gray.opacity(0.5) : item.backgroundColor) ?? .white, style: StrokeStyle(lineWidth: 1))
            )
        }
        
    }
}

#Preview {
    CustomButton()
}
