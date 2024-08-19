//
//  ReconfirmButton.swift
//  HARUCHI
//
//  Created by 이슬기 on 8/20/24.
//

import SwiftUI

struct ReconfirmButton: View {
    var body: some View {
        ZStack{
            Rectangle()
                .frame(width: 281, height: 142)
                .foregroundStyle(.white)
                .cornerRadius(5)
            VStack(alignment: .leading, spacing: 13){
                Text("정말 탈퇴하시겠어요?")
                    .font(.haruchi(.body_sb16))
                    .foregroundStyle(.black)
                Text("모든 정보가 삭제되며, 복구할 수 없습니다.")
                    .font(.haruchi(.button12))
                HStack(spacing: 13){
                    Button(action: {}) {
                        Text("취소")
                            .font(.haruchi(size: 12, family: .SemiBold))
                    }.foregroundStyle(Color.gray7)
                        .frame(width: 115, height: 38)
                        .background(Color.gray2)
                        .cornerRadius(3)
                    
                    Button(action: {}) {
                        Text("탈퇴하기")
                            .font(.haruchi(size: 12, family: .SemiBold))
                    }.foregroundStyle(.white)
                        .frame(width: 115, height: 38)
                        .background(Color.mainBlue)
                        .cornerRadius(3)
                }
            }.padding(.top, 7)
        }
    }
}

#Preview {
    ReconfirmButton()
}
