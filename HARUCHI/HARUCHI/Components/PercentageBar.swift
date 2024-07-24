//
//  PercentageBar.swift
//  HARUCHI
//
//  Created by 이상엽 on 7/24/24.
//

import SwiftUI


struct PercentageBar: View {
    var percentage: CGFloat
    
    var body: some View {
        HStack{
            Text("₩")
                .foregroundColor(Color.mainBlue)
                .font(.haruchi(.button14))
            
            ZStack(alignment: .leading) {
                
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 315, height: 19)
                    .foregroundColor(.gray.opacity(0.2))
                
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 315 * (percentage / 100), height: 19)
                    .foregroundColor(Color.purple)
                
                Text("\(Int(percentage))%")
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
        PercentageBar(percentage: 75)

    }
}
