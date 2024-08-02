//
//  CircleButton.swift
//  HARUCHI
//
//  Created by 이상엽 on 7/17/24.
//

import SwiftUI

struct CustomColors {
    static let lightBlue = Color(red: 0.918, green: 0.949, blue: 1.0)
}

//커테고리(동그라미) 버튼
struct CircleButton: View {
    let imageName: String
    let text: String
    let size: CGFloat
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 0) {
                Spacer(minLength: 0)
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 48, height: 48)
                
                Spacer(minLength: 0)
                
                Text(text)
                    .font(.haruchi(size: 11, weight: 400))
                    .foregroundColor(.black)
            }
            .padding(.top, 30)
            .padding(.bottom, 30)
            .frame(width: size, height: size)
            .background(CustomColors.lightBlue)
            .clipShape(Circle())
        }
    }
}

#Preview {
    VStack{
        CircleButton(imageName: "circle_youtube", text: "구독", size: 90) {
            
        }
    }
}
