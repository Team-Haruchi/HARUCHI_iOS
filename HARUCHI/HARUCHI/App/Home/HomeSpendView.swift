//
//  HomeSpendView.swift
//  HARUCHI
//
//  Created by 채리원 on 7/25/24.
//

import SwiftUI

struct HomeSpendView: View {
    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                Text("남은 일정과 금액")
                    .font(.haruchi(.h2))
                    .foregroundColor(Color.black)
                
                Text("D-14 / 230000원")
                    .font(.haruchi(.caption3))
                    .foregroundColor(Color.gray5)
                
                Text("하루치 20000원")
                    .font(.haruchi(.h1))
                    .foregroundColor(Color.gray5)
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
    }
}

#Preview {
    HomeSpendView()
}
