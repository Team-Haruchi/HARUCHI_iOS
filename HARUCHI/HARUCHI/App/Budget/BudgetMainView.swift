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
            PercentageBar(viewModel: percent)
            Spacer()
                
        }//VStack
    }
}

#Preview {
    BudgetMainView()
}
