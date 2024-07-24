//
//  BudgetMainView.swift
//  HARUCHI
//
//  Created by 이상엽 on 7/23/24.
//

import SwiftUI

struct BudgetMainView : View {
    var body: some View {
        VStack(spacing:0){
            HStack{
                Image("haruchiLogoBold1")
                Spacer()
                Button(action:{
                    
                }){
                    Image(systemName: "bell")
                        .foregroundColor(.gray)
                }
                    }//HStack
            PercentageBar(percentage: 20)
            Spacer()
                
        }//VStack
    }
}

#Preview {
    BudgetMainView()
}
