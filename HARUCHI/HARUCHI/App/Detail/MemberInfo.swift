import SwiftUI

struct MemberInfo: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 15){
            HStack{
                Text("계정 정보")
                    .padding(.top, 21)
                    .font(.haruchi(.body_m16))
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: 10){
                Text("닉네임")
                    .font(.haruchi(.button14))
                Text("저축왕")
                    .font(.haruchi(.button12))
                    .foregroundStyle(Color.gray7)
            }.frame(height: 50)
            
            VStack(alignment: .leading, spacing: 10){
                Text("이메일")
                    .font(.haruchi(.button14))
                // AttributedString으로 이메일 텍스트를 명시적으로 정의
                Text(AttributedString("haruchi@naver.com", attributes: .init([.foregroundColor: UIColor(Color.gray7)])))
                    .font(.haruchi(.button12))
            }.frame(height: 50)
            
            VStack(alignment: .leading, spacing: 10){
                Text("가입일")
                    .font(.haruchi(.button14))
                Text("2024.01.01")
                    .font(.haruchi(.button12))
                    .foregroundStyle(Color.gray7)
            }.frame(height: 50)
            
            Spacer()
        }.padding(.horizontal, 24)
            .navigationBarBackButtonHidden(true)
            .disableAutocorrection(true)
            .backButtonStyle()
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("계정/정보")
                        .font(.haruchi(.h2))
                        .foregroundColor(.black)
                }
            }
            .toolbar(.hidden, for: .tabBar)
    }
}

#Preview {
    MemberInfo()
}
