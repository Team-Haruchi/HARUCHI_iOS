//
//  HomeSpendView.swift
//  HARUCHI
//
//  Created by 채리원 on 7/25/24.
//

import SwiftUI

struct HomeSpendView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject private var viewModel = HomeViewModel()

    var body: some View {
        VStack {
            GeometryReader { geometry in
                VStack(spacing: 0) {
                    HStack {
                        VStack(alignment: .leading, spacing: 0) {
                            Text("남은 일정과 금액")
                                .font(.haruchi(.h2))
                                .foregroundColor(Color.black)
                                .padding(.top, 21)
                                .padding(.bottom, 10)
                            
                            Text("D-14 / 230000원")
                                .font(.haruchi(.caption3))
                                .foregroundColor(Color.gray5)
                                .padding(.bottom, 25)
                            
                            TextField("하루치 20000원", text: $viewModel.money)
                                .font(.haruchi(.h2))
                                .foregroundColor(Color.black)
                                .keyboardType(.numberPad)
                                .multilineTextAlignment(.leading)
                        }
                        Spacer()
                    }
                    .padding(.horizontal, 24)
                    
                    HStack {
                        Text("분류")
                            .foregroundColor(Color.gray5)
                            .font(.haruchi(.body_r16))
                        
                        Spacer()
                        
                        ForEach(["수입", "지출"], id: \.self) { category in
                            Text(category)
                                .background(Color.clear)
                                .foregroundColor(viewModel.selectedType == category ? Color.black : Color.gray5)
                                .font(viewModel.selectedType == category ? .haruchi(.body_sb16) : .haruchi(.body_r16))
                                .onTapGesture {
                                    viewModel.selectedType = category
                                    if category == "지출" {
                                        viewModel.selectedCategory = "미분류"
                                        viewModel.upSpendSheet = true
                                    } else {
                                        viewModel.selectedCategory = "미분류"
                                        viewModel.showIncomeSheet = true
                                    }
                                }
                            
                            // 수입 지출 중간 간격
                            if category != "지출" {
                                Spacer().frame(width: 22)
                            }
                        }
                        .background(Color.clear)
                        .clipShape(Capsule())
                    }
                    .frame(width: 345, height: 45)
                    .padding(.horizontal, 24)
                    .padding(.top, 40)
                    
                    Spacer().frame(height: 10)
                    
                    HStack {
                        Text("카테고리")
                        
                        Spacer()
                        
                        Text(viewModel.selectedCategory == "미분류" ? "미분류" : viewModel.selectedCategory)
                            .font(viewModel.selectedCategory == "미분류" ? .haruchi(.body_r16) : .haruchi(.body_sb16))
                            .foregroundColor(viewModel.selectedCategory == "미분류" ? Color.gray5 : Color.black)
                        Image(systemName: "chevron.right")
                    }
                    .font(.haruchi(.body_r16))
                    .foregroundColor(Color.gray5)
                    .frame(width: 345, height: 45)
                    .padding(.horizontal, 24)
                    .onTapGesture {
                        if viewModel.selectedType == "지출" {
                            viewModel.upSpendSheet = true
                        }
                    }
                    
                    // action 나중에 바꾸기
                    if viewModel.showMainButton {
                        MainButton(text: "저장하기", enable: viewModel.selectedCategory != "미분류", action: viewModel.hideKeyboard)
                        .padding(.top, 400)
                    }
                }
                .onChange(of: viewModel.selectedCategory) { oldValue, newValue in
                    if newValue != "미분류" && newValue != "지출" {
                        viewModel.showMainButton = true
                    }
                }
                .onChange(of: viewModel.selectedIncome) { oldValue, newValue in
                    if newValue != "미분류" && newValue != "수입" {
                        viewModel.selectedCategory = newValue
                        viewModel.showIncomeSheet = true
                    }
                }
                Spacer()
                
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            KeypadButton(
                                text: "저장하기", enable: !viewModel.money.isEmpty, action: viewModel.hideKeyboard
                            )
                        }
                    }
                    .navigationBarBackButtonHidden(true)
                    .disableAutocorrection(true)
                    .backButtonStyle()
            }
        }
        .sheet(isPresented: $viewModel.upSpendSheet) {
            SpendSheetView(selectedCategory: $viewModel.selectedCategory)
                .presentationDragIndicator(.hidden)
                .presentationDetents([.height(450)])
        }
        .sheet(isPresented: $viewModel.showIncomeSheet) {
            IncomeSheetView(selectedIncome: $viewModel.selectedIncome)
                .presentationDragIndicator(.hidden)
                .presentationDetents([.height(260)])
        }
    }
}

#Preview {
    HomeSpendView()
}
