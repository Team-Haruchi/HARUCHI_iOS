import SwiftUI

struct CancelMembershipView: View {
    @FocusState private var isFocused: Bool // TextEditor의 포커스 상태를 추적
    @StateObject private var viewModel = CancelMembershipViewModel() // ViewModel 객체 생성
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 0){
                HStack{
                    Text("저축왕님\n정말 탈퇴하시겠어요?")
                        .font(.haruchi(.h2))
                        .padding(.top, 21)
                    Spacer()
                }.padding(.horizontal, 26)
                
                HStack{
                    Image("cancelMember_caution")
                        .resizable()
                        .frame(width: 17, height: 17)
                    Text("지금 탈퇴하시면 하루치 서비스를 더이상 사용하실 수 없게 돼요!")
                        .font(.haruchi(.button12))
                }.padding(.top, 25)
                    .padding(.horizontal, 26)
                
                HStack{
                    Image("cancelMember_caution")
                        .resizable()
                        .frame(width: 17, height: 17)
                    Text("탈퇴 후에는 이전의 회원정보는 불러올 수 없어요!")
                        .font(.haruchi(.button12))
                }.padding(.top, 15)
                    .padding(.horizontal, 26)
                
                Text("떠나시는 이유를 알려주세요")
                    .font(.haruchi(.body_sb16))
                    .frame(height: 19)
                    .padding(.top, 36.5)
                    .padding(.horizontal, 26)
                
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 0)
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.sub3Blue))
                    .frame(height: 110)
                    .overlay(
                        ZStack(alignment: .topLeading) {
                            if viewModel.message.isEmpty && !isFocused { // 텍스트가 비어 있고, 포커스가 없을 때만 플레이스홀더 표시
                                Text("서비스 탈퇴 사유에 대해 알려주세요.\n고객님의 소중한 피드백을 담아\n더 나은 서비스로 보답 드리도록 하겠습니다.")
                                    .font(.haruchi(.button12))
                                    .foregroundColor(Color.gray5)
                                    .padding(15)
                            }

                            TextEditor(text: $viewModel.message)
                                .font(.haruchi(.button12))
                                .foregroundColor(.black)
                                .padding(15)
                                .scrollContentBackground(.hidden)
                                .background(Color.clear)
                                .multilineTextAlignment(.leading)
                                .focused($isFocused) // 포커스 상태를 추적
                        }
                    )
                    .padding(.top, 26)
                    .padding(.horizontal, 26)
                
                Spacer()
                
                Button(action: {
                    viewModel.isChecked.toggle() // 버튼 클릭 시 체크 상태 변경
                }) {
                    HStack {
                        Image(viewModel.isChecked ? "cancelMember_checked" : "cancelMember_unchecked")
                            .resizable()
                            .frame(width: 17, height: 17)
                        Text("위 사항에 모두 동의합니다.")
                            .font(.haruchi(.body_m14))
                            .foregroundColor(.black)
                    }
                }
                .padding(.bottom, 17)
                .padding(.horizontal, 26)
                
                MainButton(
                    text: "탈퇴하기",
                    enable: !viewModel.message.isEmpty && viewModel.isChecked,
                    action: viewModel.cancelMembership
                )
            }
            .navigationBarBackButtonHidden(true)
            .disableAutocorrection(true)
            .backButtonStyle()
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("회원탈퇴")
                        .font(.haruchi(.h2))
                        .foregroundColor(.black)
                }
            }
            .toolbar(.hidden, for: .tabBar)
            .ignoresSafeArea(.keyboard)
            .contentShape(Rectangle()) // 제스처 인식 영역 설정
            .onTapGesture {
                // 텍스트 에디터 외부를 누르면 키보드 내리기
                isFocused = false
            }
            .fullScreenCover(isPresented: $viewModel.isCanceled) {
                LoginView(appState: AppState()) // 로그인 화면
                    .navigationBarBackButtonHidden(true) // 로그인 화면에서 뒤로 가기 버튼 숨기기
            }
        }
    }
}

#Preview {
    CancelMembershipView()
}
