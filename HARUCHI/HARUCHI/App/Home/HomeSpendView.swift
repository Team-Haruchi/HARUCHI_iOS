//
//  HomeSpendView.swift
//  HARUCHI
//
//  Created by 채리원 on 7/25/24.
//

import SwiftUI

struct HomeSpendView: View {
    @State private var money = ""

    var category = ["수입", "지출"]
    @State private var selectedCategory = ""
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    Text("남은 일정과 금액")
                        .font(.haruchi(.h2))
                        .foregroundColor(Color.black)
                        .padding(.bottom, 10)
                    
                    Text("D-14 / 230000원")
                        .font(.haruchi(.caption3))
                        .foregroundColor(Color.gray5)
                        .padding(.bottom, 25)
                    
                    TextField("하루치 20000원", text: $money)
                        .font(.haruchi(.h2))
                        .foregroundColor(Color.black)
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.leading)
                }
                Spacer()
            }
            .padding(.horizontal, 24)
            
            HStack {
                Text("분류")
                    .foregroundColor(Color.gray5)
                    .font(.haruchi(.body_r16))
                
                Spacer()
                
                ForEach(category, id: \.self) { category in
                    Text(category)
                        .background(Color.clear)
                        .foregroundColor(selectedCategory == category ? Color.black : Color.gray5)
                        .font(selectedCategory == category ? .haruchi(.body_sb16) : .haruchi(.body_r16))
                        .onTapGesture {
                            selectedCategory = category
                        }
                    
                    // 수입 지출 중간 간격
                    if category != self.category.last {
                        Spacer().frame(width: 22)
                    }
                }
                .background(Color.clear)
                .clipShape(Capsule())
            }
            .frame(width: 345, height: 45)
            .padding(.horizontal, 24)
            .padding(.top, 40)
            
            HStack {
                Text("카테고리")
                
                Spacer()
                
                Text("미분류")
                Image(systemName: "chevron.right")
            }
            .font(.haruchi(.body_r16))
            .foregroundColor(Color.gray5)
            .frame(width: 345, height: 45)
            .padding(.horizontal, 24)
        }
        Spacer()
        
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    KeypadButton(
                        text: "저장하기", enable: !money.isEmpty, action: { print("버튼 눌림 ㅇㅇ") }
                    )
                }
            }
    }
}

#Preview {
    HomeSpendView()
}
