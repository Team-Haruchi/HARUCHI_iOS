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

    @ObservedObject var viewModel: HomeViewModel
    @ObservedObject var budgetViewModel: BudgetMainViewModel

    @State private var selectedOption: String? = nil
    @State private var selectedYear: Int = Calendar.current.component(.year, from: Date())
    @State private var selectedMonth: Int = Calendar.current.component(.month, from: Date())
    @State private var selectedDay: Int = Calendar.current.component(.day, from: Date())

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
                                    Text("지출 \(viewModel.expenditureList.map { $0.expenditureAmount ?? 0 }.reduce(0, +)) 원")
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
                                
                                ForEach(viewModel.expenditureList, id: \.expenditureId) { expenditure in
                                    HStack {
                                        if let imageName = categoryImages[expenditure.expenditureCategory?.krName ?? "기타"] {
                                            SmallCircleButton(image: imageName, text: "\(expenditure.expenditureCategory?.krName ?? "기타")", charge: "\(expenditure.expenditureAmount ?? 0)원", action: {
                                                print("ㅇㅋ")
                                            })
                                        }
                                    }
                                    .padding(.bottom, 10)
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 24)
                        }
                        .scrollBounceBehavior(.basedOnSize)
                        .padding(.bottom, 30)
                        
                        HStack {
                            Rectangle()
                                .fill(Color.black)
                                .frame(height: 1)
                        }
                        .padding(.horizontal, 24)
                        
                        .padding(.bottom, 12)
                        
                        HStack {
                            Image(systemName: "chevron.down")
                            
                            Spacer()
                            
                            Text("\(viewModel.money)원") // Sum of all expenditures
                                .font(.haruchi(.h2))
                                .foregroundColor(Color.black)
                        }
                        .padding(.horizontal, 24)
                        Spacer().frame(height: 15)
                        
                        VStack(spacing: 0) {
                            Button(action: {
                                selectedOption = "차감하기"
                                viewModel.closeAmount(year: selectedYear, month: selectedMonth, day: selectedDay)
                            }) {
                                HStack {
                                    Text("남은 일수에서 1/n")
                                    
                                    Spacer()
                                    
                                    Text("고르게 분배하기")
                                    
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
                                    Text("\(budgetViewModel.safeBox)원")
                                    
                                    Spacer()
                                    
                                    Text("세이프박스")
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
                                    action: {
                                        viewModel.hideKeyboard()
//                                        viewModel.closeAmount(year: selectedYear, month: selectedMonth, day: selectedDay)
                                        presentationMode.wrappedValue.dismiss()
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
        .onAppear {
            viewModel.closeReceipt()
            budgetViewModel.loadBudget()
            budgetViewModel.loadSafeBox()
        }
    }
}
