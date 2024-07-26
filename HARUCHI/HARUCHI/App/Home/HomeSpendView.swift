//
//  HomeSpendView.swift
//  HARUCHI
//
//  Created by 채리원 on 7/25/24.
//

import SwiftUI

struct HomeSpendView: View {
    @State private var money = ""
    
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                Text("남은 일정과 금액")
                    .font(.haruchi(.h2))
                    .foregroundColor(Color.black)
                
                Text("D-14 / 230000원")
                    .font(.haruchi(.caption3))
                    .foregroundColor(Color.gray5)
                
                TextField("하루치 20000원", text: $money)
                    .font(.haruchi(.h2))
                    .foregroundColor(Color.gray5)
                    .keyboardType(.numberPad)
                    .multilineTextAlignment(.leading)
            }
            .padding(.leading, 24)
            
            HStack {
                Text("분류")
                
                Text("수입 지출")
            }
            
            HStack {
                Text("분류")
                
                Text("수입 지출")
            }
        }
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
