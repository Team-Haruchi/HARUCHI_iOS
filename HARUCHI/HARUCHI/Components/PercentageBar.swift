//
//  PercentageBar.swift
//  HARUCHI
//
//  Created by 이상엽 on 7/24/24.
//

import SwiftUI
import Combine


class BudgetPercentage: ObservableObject { //ObservableObject 프로토콜을 채택해서 이 객체의 변화를 감지
    
    //퍼센티지바 수치
    @Published var percentage: CGFloat = 51.0 //@Published를 사용하여 변수를 선언하면 변수가 변경될 때 뷰가 자동으로 갱신
    
}

struct PercentageBar: View {
    @ObservedObject var viewModel: BudgetPercentage
    
    var body: some View {
        HStack{
            Text("₩")
                .foregroundColor(Color.mainBlue)
                .font(.haruchi(.button14))
            
            ZStack(alignment: .leading) {
                
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 315, height: 19)
                    .foregroundColor(Color.sub3Blue)
                
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 315 * (viewModel.percentage / 100), height: 19)
                    .foregroundColor(Color.purple)
                
                Text("\(Int(viewModel.percentage))%")
                    .foregroundColor(Color.black)
                    .font(.haruchi(.button12))
                    .padding(.trailing, 7)
                    .frame(width: 315, height: 19, alignment: .trailing)
                
            }//ZStack
        }//HStack
            
        
    }
}

#Preview {
    VStack{
        @StateObject var percent3 = BudgetPercentage()
        @StateObject var percent4 = BudgetPercentage()
        PercentageBar(viewModel: percent3)
        PercentageBar(viewModel: percent4)

    }
}
