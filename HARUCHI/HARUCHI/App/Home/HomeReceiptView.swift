//
//  HomeReceiptView.swift
//  HARUCHI
//
//  Created by 채리원 on 8/5/24.
//

import SwiftUI

struct HomeReceiptView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject private var viewModel = HomeViewModel()
    
    var selectedCategory: String

    var body: some View {
        NavigationStack {
            VStack {
                GeometryReader { geometry in
                    VStack(spacing: 0) {
                        HStack {
                            VStack(alignment: .leading, spacing: 0) {
                                Text("오늘 지출 영수증")
                                    .font(.haruchi(.h2))
                                    .foregroundColor(Color.black)
                                    .padding(.top, 21)
                                    .padding(.bottom, 10)
                                
                                // 나중에 바꾸기
                                Text("하루치 20000원")
                                    .font(.haruchi(.caption3))
                                    .foregroundColor(Color.gray5)
                                    .padding(.bottom, 25)
                                
                                HStack {
                                    Text("20000원")
                                }
                                .font(.haruchi(.h1))
                                .foregroundColor(Color.black)
                                .multilineTextAlignment(.leading)
                            }
                            Spacer()
                        }
                        .padding(.horizontal, 24)
                        .padding(.bottom, 70)
                        
                        // 라스트 커스텀 ?
                        ScrollView {
                            VStack(alignment: .leading, spacing: 0) {
                                Text("15일 오늘")
                                    .foregroundColor(Color.gray5)
                                    .font(.haruchi(.caption3))
                                    .padding(.leading, 24)
                                    .padding(.bottom, 15)
                                
                                SmallCircleButton(image: "circle_pizza", text: viewModel.selectedCategory, charge: "5000원", action: {print("ㅇㅋ")})
                            }
                        }

                        
                        HStack {
                            Rectangle()
                                .fill(Color.black)
                                .frame(height: 1)
                        }
                        .padding(.horizontal, 24)
                        .padding(.top, 100)
                        .padding(.bottom, 12)
                        
                        HStack {
                            Image(systemName: "chevron.down")
                            
                            Spacer()
                            
                            // 이거 데이터 넘겨줘야힘
                            Text("4000원")
                                .font(.haruchi(.h2))
                                .foregroundColor(Color.black)
                        }
                        .padding(.horizontal, 24)
                        Spacer().frame(height: 15)
                        
                        VStack(spacing: 0) {
                            HStack {
                                Text("남은 일수에서 1/n")
                                
                                Spacer()
                                
                                Text("고르게 차감하기")
                            }
                            .padding()
                            
                            Divider()
                                .frame(height: 2)
                            
                            HStack {
                                Text("￦ 70000")
                                
                                Spacer()
                                
                                Text("세이프박스")
                            }
                            .padding()
                        }
                        .font(.haruchi(.body_m14))
                        .foregroundColor(Color.gray5)
                        .border(Color.gray5)
                        .frame(maxWidth: .infinity)
                        .frame(width: 345, height: 107)
                        
                        VStack {
                            MainButton(
                                text: "치김하기",
                                action: { viewModel.hideKeyboard()
                            })
                        }
                        .padding(.top, 39)
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .disableAutocorrection(true)
            .backButtonStyle()
        }
        Spacer()
    }
}
