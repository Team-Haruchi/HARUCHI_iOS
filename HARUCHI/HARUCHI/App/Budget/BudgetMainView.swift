//
//  BudgetMainView.swift
//  HARUCHI
//
//  Created by 이상엽 on 7/23/24.
//

import SwiftUI

struct BudgetMainView : View {
    
    @StateObject private var percent = BudgetPercentage()
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Image("haruchiLogoBold1")
                Spacer()
                Button(action:{
                    
                }){
                    Image("notification")
                        .frame(width: 30, height: 30)
                }
                    }//HStack
            HStack{
                Text("한 달 예산")
                    .font(.haruchi(.button14))
                    .foregroundColor(Color.gray6)
                Spacer()
                Button(action: {
                    print("수정 클릭")
                }){
                    Text("수정")
                        .font(.haruchi(.button14))
                        .foregroundColor(Color.gray6)
                }
            }//HStack
            .padding(.top, 15)

            Text("700,000원")
                .font(.haruchi(.h2))
                .padding(.top, 15)

            PercentageBar(viewModel: percent)
                .padding(.top, 20)

            RoundedRectangle(cornerRadius: 8)
                .frame(width: 345, height: 306)
                .foregroundColor(Color.sub3Blue)
                .padding(.top, 15)

            RoundedRectangle(cornerRadius: 20)
                .frame(width: 345, height: 55)
                .foregroundColor(Color.sub3Blue)
                .padding(.top, 20)

            Spacer()
                
        }//VStack
        .padding(.leading, 24)
        .padding(.trailing, 24)
    }
}

#Preview {
    BudgetMainView()
}
