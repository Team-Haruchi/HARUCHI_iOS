//
//  SmallCircleButton.swift
//  HARUCHI
//
//  Created by 채리원 on 8/4/24.
//

import SwiftUI

struct SmallCircleButton: View {
    
    private var image: String
    private var size: CGFloat
    private var text: String
    private var charge: String
    private var action: () -> Void
    
    var body: some View {
        HStack {
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: 22, height: 22)
                .background(CustomColors.lightBlue)
                .clipShape(Circle())
            
            Spacer(minLength: 10)
            
            Text(text)
                .font(.haruchi(.button12))
                .foregroundStyle(.black)
            
            Spacer()
            
            Text(charge)
                .font(.haruchi(.button12))
                .foregroundStyle(Color.gray5)
        }
        .frame(width: size, height: size)
        .padding(.horizontal, 24)
    }
}
