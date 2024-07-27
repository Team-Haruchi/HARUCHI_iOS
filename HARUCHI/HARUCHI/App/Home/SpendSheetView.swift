//
//  SpendSheetView.swift
//  HARUCHI
//
//  Created by 채리원 on 7/27/24.
//

import SwiftUI

struct SpendSheetView: View {
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            HStack {
                Rectangle()
                    .fill(Color.sub3Blue)
                    .frame(height: 45)
                    .overlay(
                        HStack {
                            Text("카테고리")
                                .font(.haruchi(.body_r16))
                                .foregroundColor(Color.black)
                            Spacer()
                        }
                        .padding(.leading, 23)
                    )
            }
            .padding(.bottom, 30)
            
            HStack(alignment: .center) {
                CircleButton(imageName: "circle_pizza", text: "식비", size: 90, action: {print("식비")})
                    .padding(.trailing, 30)
                CircleButton(imageName: "circle_coffee", text: "커피", size: 90, action: {print("커피")})
                    .padding(.trailing, 30)
                CircleButton(imageName: "circle_creditCard", text: "교통", size: 90, action: {print("교통")})
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 30)
            .font(.haruchi(.caption3))
            .foregroundColor(Color.black)
            
            HStack {
                CircleButton(imageName: "circle_gym", text: "취미", size: 90, action: {print("취미")})
                    .padding(.trailing, 30)
                CircleButton(imageName: "circle_cart", text: "패션", size: 90, action: {print("패션")})
                    .padding(.trailing, 30)
                CircleButton(imageName: "circle_books", text: "교육", size: 90, action: {print("교육")})
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 30)
            .font(.haruchi(.caption3))
            .foregroundColor(Color.black)
            
            HStack {
                CircleButton(imageName: "circle_networking", text: "경조사", size: 90, action: {print("경조사")})
                    .padding(.trailing, 30)
                CircleButton(imageName: "circle_youtube", text: "구독", size: 90, action: {print("구독")})
                    .padding(.trailing, 30)
                CircleButton(imageName: "circle_etc", text: "기타", size: 90, action: {print("기타")})
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 30)
            .font(.haruchi(.caption3))
            .foregroundColor(Color.black)
        }
    }
}

#Preview {
    SpendSheetView()
}
