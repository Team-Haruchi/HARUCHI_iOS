//
//  SpendSheetView.swift
//  HARUCHI
//
//  Created by 채리원 on 7/27/24.
//

import SwiftUI

struct SpendSheetView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedCategory: String
    
    
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
                                .padding(.leading, 33)
                            Spacer()
                        }
                    )
            }
   
            
            ScrollView {
                HStack(alignment: .center) {
                    CircleButton(imageName: "circle_pizza", text: "식비", size: 90, action: {
                        selectedCategory = "식비"
                        presentationMode.wrappedValue.dismiss()
                    })
                    .padding(.trailing, 30)
                    
                    CircleButton(imageName: "circle_coffee", text: "커피", size: 90, action: {
                        selectedCategory = "커피"
                        presentationMode.wrappedValue.dismiss()
                    })
                    .padding(.trailing, 30)
                    
                    CircleButton(imageName: "circle_creditCard", text: "교통", size: 90, action: {
                        selectedCategory = "교통"
                        presentationMode.wrappedValue.dismiss()
                    })
                }
                .padding(.top, 30)
                .padding(.horizontal, 40)
                .padding(.bottom, 30)
                .font(.haruchi(.caption3))
                .foregroundColor(Color.black)
                
                HStack {
                    CircleButton(imageName: "circle_gym", text: "취미", size: 90, action: {
                        selectedCategory = "취미"
                        presentationMode.wrappedValue.dismiss()
                    })
                    .padding(.trailing, 30)
                    
                    CircleButton(imageName: "circle_cart", text: "패션", size: 90, action: {
                        selectedCategory = "패션"
                        presentationMode.wrappedValue.dismiss()
                    })
                    .padding(.trailing, 30)
                    
                    CircleButton(imageName: "circle_books", text: "교육", size: 90, action: {
                        selectedCategory = "교육"
                        presentationMode.wrappedValue.dismiss()
                    })
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 30)
                .font(.haruchi(.caption3))
                .foregroundColor(Color.black)
                
                HStack {
                    CircleButton(imageName: "circle_networking", text: "경조사", size: 90, action: {
                        selectedCategory = "경조사"
                        presentationMode.wrappedValue.dismiss()
                    })
                    .padding(.trailing, 30)
                    
                    CircleButton(imageName: "circle_youtube", text: "구독", size: 90, action: {
                        selectedCategory = "구독"
                        presentationMode.wrappedValue.dismiss()
                    })
                    .padding(.trailing, 30)
                    
                    CircleButton(imageName: "circle_etc", text: "기타", size: 90, action: {
                        selectedCategory = "기타"
                        presentationMode.wrappedValue.dismiss()
                    })
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 42)
                .font(.haruchi(.caption3))
                .foregroundColor(Color.black)
            }
            .frame(height: 436)
            .scrollBounceBehavior(.basedOnSize)
        }
    }
}

#Preview {
    SpendSheetView(selectedCategory: .constant(""))
}
