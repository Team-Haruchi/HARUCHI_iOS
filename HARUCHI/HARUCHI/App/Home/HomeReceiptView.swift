//
//  HomeReceiptView.swift
//  HARUCHI
//
//  Created by 채리원 on 8/5/24.
//

import SwiftUI

struct HomeReceiptView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var selectedCategory: String

    @ObservedObject private var viewModel = HomeViewModel()
    @ObservedObject private var budgetViewModel = BudgetMainViewModel()

    @State private var selectedOption: String? = nil


    let categoryImages: [String: String] = [
        "식비": "circle_pizza",
        "커피": "circle_coffee",
        "교통": "circle_creditCard",
        "취미": "circle_gym",
        "패션": "circle_cart",
        "교육": "circle_books",
        "경조사": "circle_networking",
        "구독": "circle_youtube",
        "기타": "circle_etc"
    ]

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
                                
                                Text("하루치 \(budgetViewModel.dayBudget)원")
                                    .font(.haruchi(.caption3))
                                    .foregroundColor(Color.gray5)
                                    .padding(.bottom, 25)
                                
                                HStack {
                                    Text("지출 \(viewModel.money) 원")
                                }
                                .font(.haruchi(.h1))
                                .foregroundColor(Color.black)
                                .multilineTextAlignment(.leading)
                            }
                            Spacer()
                        }
                        .padding(.horizontal, 24)
                        .padding(.bottom, 50)
                        
                        ScrollView {
                            VStack(alignment: .leading, spacing: 0) {
                                Text(viewModel.formattedDate)
                                    .foregroundColor(Color.gray5)
                                    .font(.haruchi(.caption3))
                                    .padding(.bottom, 15)
                                    .onAppear {
                                        viewModel.updateDate()
                                    }
                                
                                if let imageName = categoryImages[selectedCategory] {
                                    SmallCircleButton(image: imageName, text: "\(selectedCategory)", charge: "\(viewModel.money)원", action: {
                                        print("ㅇㅋ")
                                    })
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 24)
                        }
                        .scrollBounceBehavior(.basedOnSize)

                        
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
                            
                            Text("4000원")
                                .font(.haruchi(.h2))
                                .foregroundColor(Color.black)
                        }
                        .padding(.horizontal, 24)
                        Spacer().frame(height: 15)
                        
                        VStack(spacing: 0) {
                            Button(action: {
                                selectedOption = "차감하기"
                            }) {
                                HStack {
                                    Text("차감하기")
                                    
                                    Spacer()
                                    
                                    Text("고르게 차감하기")
                                    
                                    if selectedOption == "차감하기" {
                                        Image(systemName: "checkmark")
                                    }
                                }
                                .padding()
                            }
                            .buttonStyle(PlainButtonStyle())
                            
                            Divider()
                                .frame(height: 2)
                            
                            Button(action: {
                                selectedOption = "분배하기"
                            }) {
                                HStack {
                                    Text("세이프박스")
                                    
                                    Spacer()
                                    
                                    Text("70000원")
                                    if selectedOption == "분배하기" {
                                        Image(systemName: "checkmark")
                                    }
                                }
                                .padding()
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        .font(.haruchi(.body_m14))
                        .foregroundColor(Color.gray5)
                        .border(Color.gray5)
                        .frame(maxWidth: .infinity)
                        .frame(width: 345, height: 107)
                        
                        VStack {
                            if let option = selectedOption {
                                MainButton(
                                    text: "\(option)",
                                    action: { viewModel.hideKeyboard()
                                })
                                .padding(.top, 39)
                                
                            }
                        }
                        Spacer().frame(height: 25)
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .disableAutocorrection(true)
            .backButtonStyle()
            .toolbar(.hidden, for: .tabBar)
        }
        Spacer()
    }
}
