//
//  FinalConfirmButton.swift
//  HARUCHI
//
//  Created by 이슬기 on 8/20/24.
//

import SwiftUI

struct FinalConfirmButton: View {
    var onOK: () -> Void // 확인 버튼 클릭 시 실행할 동작
    
    var body: some View {
        ZStack{
            Rectangle()
                .frame(width: 281, height: 108.73)
                .foregroundStyle(.white)
                .cornerRadius(5)
            VStack(alignment: .leading, spacing: 19.26){
                Text("탈퇴 처리가 완료되었습니다.")
                    .font(.haruchi(.body_sb16))
                    .foregroundStyle(.black)
                    .frame(width: 178, height: 19)
                    .padding(.leading, 20)
                
                Button(action: onOK) {
                    Text("확인")
                        .font(.haruchi(size: 12, family: .SemiBold))
                }.foregroundStyle(Color.mainBlue)
                    .frame(width: 60, height: 35)
                    .padding(.leading, 220)
            }.padding(.top, 11)
        }
    }
}

//#Preview {
//    FinalConfirmButton()
//}
