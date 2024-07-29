//
//  IncomeSheetView.swift
//  HARUCHI
//
//  Created by 채리원 on 7/29/24.
//

import SwiftUI

struct IncomeSheetView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var selectedIncome: String
    var incomes = ["용돈", "월급", "부수입", "상여급", "근로소득", "기타"]
    
    var body: some View {
        VStack(spacing: 0) {

            
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

            HStack {
                Picker("Choose income", selection: $selectedIncome) {
                    ForEach(incomes, id: \.self) { income in
                        Text(income)
                            .font(.haruchi(.body_sb16))
                            .foregroundColor(selectedIncome == income ? Color.black : Color.gray7)
                            .frame(maxWidth: .infinity)
                    }
                }
                .pickerStyle(.wheel)
                .background(Color.white)
                .cornerRadius(30)
                .clipped()
            }
            .padding(.horizontal, 24)

        }
    }
}


