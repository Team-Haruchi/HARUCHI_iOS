//
//  SmallCircleButton.swift
//  HARUCHI
//
//  Created by 채리원 on 8/4/24.
//

import SwiftUI

struct SmallCircleButton: View {
    
    let image: String
    let text: String
    let charge: String
    let action: () -> Void
    
    var body: some View {
        HStack {
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: 22, height: 22)
                .background(CustomColors.lightBlue)
                .clipShape(Circle()).frame(width: 41, height: 41)
                .padding(.trailing, 10)
            
            Text(text)
                .font(.haruchi(.button12))
                .foregroundStyle(.black)
            
            Spacer()
            
            Text(charge)
                .font(.haruchi(.button12))
                .foregroundStyle(Color.gray5)
        }
        .padding(.horizontal, 24)
    }
}
