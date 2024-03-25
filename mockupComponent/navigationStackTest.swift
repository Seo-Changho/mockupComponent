//
//  navigationStackTest.swift
//  mockupComponent
//
//  Created by changho seo on 3/12/24.
//

import SwiftUI

enum StackViewType {
    case firstView
    case secondView
}

struct StackView: Hashable {
    let type: StackViewType
    let firstContent: String?
    let secondContent: String?
}


struct navigationStackTest: View {
    @State var path: [StackView] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                Text("Hello, Navigation Stack")
                Button(action: {
                    // ✅
                    path.append(StackView(type: .firstView,
                                          firstContent: "frist content",
                                          secondContent: nil))
                }) {
                    Text("push first view")
                }
                Button(action: {
                    // ✅
                    path.append(StackView(type: .secondView,
                                          firstContent: nil,
                                          secondContent: "second content"))
                }) {
                    Text("push second view")
                }
            }
            .padding()
            // ✅
            .navigationDestination(for: StackView.self) { stackView in
                switch stackView.type {
                case .firstView:
                    FirstView(content: stackView.firstContent ?? "")
                case .secondView:
                    SecondView(content: stackView.secondContent ?? "")
                }
            }
        }
    }
}

// FirstView.swift
struct FirstView: View {
    
    var content: String
    
    var body: some View {
        VStack {
            Text("First view: \(content)")
        }
        .padding()
        .background(Color.green)
    }
}

// SecondView.swift
struct SecondView: View {
    
    var content: String
    
    var body: some View {
        VStack {
            Text("Second view: \(content)")
        }
        .padding()
        .background(Color.yellow)
    }
}

extension View {
    public func appBar(title: String, backButtonAction: @escaping() -> Void) -> some View {
        self
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action: {
                backButtonAction()
            }) {
                Image("ic-back") // set backbutton image here
                    .renderingMode(.template)
                    .foregroundColor(Color.gray)
            })
    }
}


#Preview {
    navigationStackTest()
}
