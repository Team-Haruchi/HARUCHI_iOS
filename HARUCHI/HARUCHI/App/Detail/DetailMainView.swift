import SwiftUI

struct DetailMainView: View {
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading, spacing: 30){
                HStack{
                    Text("앱 정보")
                        .padding(.top, 30)
                        .font(.haruchi(.h2))
                    Spacer()
                }
                
                NavigationLink(destination: MemberInfo()) {
                    HStack {
                        Text("회원정보")
                            .font(.haruchi(.body_r16))
                            .foregroundStyle(.black)
                        Spacer()
                        Image("chevron.right")
                            .resizable()
                            .frame(width: 6, height: 13)
                    }
                }
                .frame(width: UIScreen.main.bounds.width - 48, height: 45)
                
                HStack{
                    Text("버전정보")
                        .font(.haruchi(.body_r16))
                        .foregroundStyle(.black)
                    Spacer()
                    Text("v 3.34.0")
                        .font(.haruchi(.body_r16))
                        .foregroundStyle(.black)
                }.frame(width: UIScreen.main.bounds.width - 48, height: 45)
                
                ShareLink(item: URL(string: "https://delightful-delphinium-b9c.notion.site/20716ce6a84c4bd18454d34b23a7f2e5?pvs=4")!) {
                    HStack {
                        Text("친구에게 앱 공유하기")
                            .font(.haruchi(.body_r16))
                            .foregroundStyle(.black)
                        Spacer()
                        Image("chevron.right")
                            .resizable()
                            .frame(width: 6, height: 13)
                    }
                }
                .frame(width: UIScreen.main.bounds.width - 48, height: 45)
                
                HStack{
                    Text("계정")
                        .font(.haruchi(.body_m14))
                        .foregroundStyle(Color.gray5)
                    Spacer()
                }.frame(height: 50)
                    .padding(.top, 70)
                
                NavigationLink(destination: CancelMembershipView()){
                    HStack{
                        Text("탈퇴")
                            .font(.haruchi(.body_r16))
                            .foregroundStyle(.black)
                        Spacer()
                        Image("chevron.right")
                            .resizable()
                            .frame(width: 6, height: 13)
                    }
                }.frame(width: UIScreen.main.bounds.width - 48, height: 45)
                    .padding(.top, -10)
                
                Spacer()
            }.padding(.horizontal, 24)
        }
    }
}

#Preview {
    DetailMainView()
}
