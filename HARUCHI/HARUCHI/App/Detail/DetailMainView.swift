import SwiftUI

struct DetailMainView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 30){
            HStack{
                Text("앱 정보")
                    .padding(.top, 30)
                    .font(.haruchi(.h2))
                Spacer()
            }
            
            Button(action: {}) {
                HStack{
                    Text("회원정보")
                        .font(.haruchi(.body_r16))
                        .foregroundStyle(.black)
                    Spacer()
                    Image("chevron.right")
                        .resizable()
                        .frame(width: 6, height: 13)
                }
            }.frame(width: 345, height: 45)
            
            Button(action: {}) {
                HStack{
                    Text("버전정보")
                        .font(.haruchi(.body_r16))
                        .foregroundStyle(.black)
                    Spacer()
                    Image("chevron.right")
                        .resizable()
                        .frame(width: 6, height: 13)
                }
            }.frame(width: 345, height: 45)
            
            Button(action: {}) {
                HStack{
                    Text("친구에게 앱 공유하기")
                        .font(.haruchi(.body_r16))
                        .foregroundStyle(.black)
                    Spacer()
                    Image("chevron.right")
                        .resizable()
                        .frame(width: 6, height: 13)
                }
            }.frame(width: 345, height: 45)
            
            HStack{
                Text("계정")
                    .font(.haruchi(.body_m14))
                    .foregroundStyle(Color.gray5)
                Spacer()
            }.frame(height: 50)
                .padding(.top, 70)
            
            Button(action: {}) {
                HStack{
                    Text("탈퇴")
                        .font(.haruchi(.body_r16))
                        .foregroundStyle(.black)
                    Spacer()
                    Image("chevron.right")
                        .resizable()
                        .frame(width: 6, height: 13)
                }
            }.frame(width: 345, height: 45)
                .padding(.top, -10)
            
            Spacer()
        }.padding(.horizontal, 24)
    }
}

#Preview {
    DetailMainView()
}
