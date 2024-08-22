//
//  HomeMainView.swift
//  HARUCHI
//
//  Created by 채리원 on 7/23/24.
//

import SwiftUI
import Combine

struct HomeMainView: View {
    @ObservedObject private var viewModel = HomeViewModel()
    @ObservedObject private var budgetViewModel = BudgetMainViewModel()
    @StateObject private var percent = BudgetPercentage()
    @State private var accessToken: String = ""
    @State private var selectedYear: Int = Calendar.current.component(.year, from: Date())
    @State private var selectedMonth: Int = Calendar.current.component(.month, from: Date())
    @State private var selectedDay: Int = Calendar.current.component(.day, from: Date())
    
    @State private var isEditing = false
    @State private var hasLoaded: Bool = false
        
        private func setupView() {
            viewModel.loadMonthBudget()
            viewModel.loadWeekBudget()
            viewModel.loadBudgetPercent()
//                        viewModel.closeReceipt()
            budgetViewModel.loadBudget()
            budgetViewModel.loadSafeBox()
            percent.percentage = CGFloat(viewModel.monthUsedPercent)
            
            hasLoaded = true
        }
    
    var body: some View {
        GeometryReader { geometry in
            NavigationStack {
                ScrollView {
                    VStack(spacing: 0) {
                        VStack(spacing: 0) {
                            HStack {
                                Image("HomeLogo")
                                
                                Spacer()
                                
                                // Image("HomeAlarm") 알림창 미구현
                            }
                        }
                        .padding(.horizontal, 24)
                        .padding(.top, 13)
                        .padding(.bottom, 25)
                        
                        
                        VStack(alignment: .leading, spacing: 20) {
                            
                            Text(viewModel.currentMonth)
                                .font(.haruchi(.h2))
                            
                            HStack {
                                Text("한 달 예산")
                                
                                Spacer()
                                
                                // 수정 버튼 추가
                                Button(action: {
                                    isEditing.toggle()
                                    if isEditing {
                                        viewModel.editedBudget = String(viewModel.monthBudget)
                                    }
                                }) {
                                    Text("수정")
                                        .font(.haruchi(.button14))
                                        .foregroundColor(Color.gray6)
                                }
                            }
                            
                            if isEditing {
                                HStack(spacing: 0) {
                                    TextField("예산을 입력하세요", text: $viewModel.editedBudget)
                                        .font(.haruchi(.h1))
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .keyboardType(.numberPad)
                                    
                                    Spacer().frame(width: 15)
                                    
                                    Text("원")
                                        .font(.haruchi(.h1))
                                }
                                
                                Button(action: {
                                    viewModel.monthBudget = Int(viewModel.editedBudget)!
                                    viewModel.editMonthlyBudget()
                                    isEditing = false
                                }) {
                                    Text("저장")
                                        .font(.haruchi(.button14))
                                        .foregroundColor(Color.black)
                                }
                            } else {
                                HStack(spacing: 0) {
                                    Text("\(viewModel.monthBudget)")
                                    
                                    Text("원")
                                }
                                .font(.haruchi(.h1))
                            }
                        }
                        .padding(.horizontal, 24)
                        PercentageBar(percentViewModel: percent)
                            .padding(.top, 16)
                        
                        VStack(spacing: 0) {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.sub3Blue)
                                .frame(width: geometry.size.width * 0.9, height: 120)
                                .overlay (
                                    
                                    VStack(spacing: 0) {
                                        Text(viewModel.formattedDate)
                                            .font(.haruchi(.body_r16))
                                            .foregroundColor(Color.black)
                                            .padding(.leading, 22)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .onAppear {
                                                viewModel.updateDate()
                                            }
                                        
                                        Spacer()
                                        
                                        HStack {
                                            Spacer()
                                            Text("하루치 \(budgetViewModel.dayBudget)원")
                                                .font(.haruchi(.h2))
                                                .foregroundColor(Color.gray5)
                                            
                                            
                                            NavigationLink(destination: HomeSpendView()) {
                                                Image(systemName: "plus")
                                                    .font(.system(size: 16, weight: .bold))
                                                    .frame(width: 30, height: 30)
                                                    .foregroundColor(Color.mainBlue)
                                                    .background(Circle().fill(Color.white))
                                            }
                                        }
                                        .padding(.horizontal, 22)
                                        Rectangle()
                                            .foregroundColor(Color.gray5)
                                            .frame(height: 2)
                                            .padding(.top, 7)
                                            .padding(.bottom, 9)
                                            .padding(.horizontal, 22)
                                    }
                                        .padding(.vertical, 19)
                                )
                        }
                        .padding(.top, 20)
                        
                        VStack(spacing: 0) {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.gray1)
                                .frame(width: geometry.size.width * 0.9, height: 58)
                                .overlay {
                                    HStack {
                                        ZStack {
                                            Circle()
                                                .frame(width: 42, height: 42)
                                                .foregroundColor(Color.white)
                                            
                                            Image("HomeClock")
                                                .frame(width: 28, height: 30)
                                                .scaledToFit()
                                        }
                                        
                                        Text("오늘 지출을 마감하세요")
                                            .font(.haruchi(.button12))
                                            .foregroundColor(Color.gray7)
                                        
                                        Spacer()
                                        
                                        Text("지출 마감하기")
                                            .font(.haruchi(.body_r16))
                                            .foregroundColor(Color.black)
                                        
                                        Image(systemName: "chevron.right")
                                            .foregroundColor(Color.black)
                                    }
                                    .padding(.horizontal, 10)
                                }
                                .onTapGesture {
                                    viewModel.closeReceipt()
                                    viewModel.navigateToReceipt = true
                                }

                                .padding(.top, 20)
                                .navigationDestination(isPresented: $viewModel.navigateToReceipt) {
                                    HomeReceiptView(selectedCategory: viewModel.selectedCategory)
                                        .environmentObject(viewModel)
                                        .navigationBarBackButtonHidden(true)
                                        .disableAutocorrection(true)
                                }
                            
                            
                            VStack(spacing: 0) {
                                WeekCalendarView(viewModel: viewModel)
                                    .frame(width: geometry.size.width * 0.9, height: 128)
                            }
                            .padding(.top, 25)
                            
                            
                            VStack(spacing: 0) {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.gray1)
                                    .frame(width: geometry.size.width * 0.9, height: 58)
                                    .overlay {
                                        HStack {
                                            ZStack {
                                                Circle()
                                                    .frame(width: 42, height: 42)
                                                    .foregroundColor(Color.white)
                                                
                                                Image("HomeCoin")
                                                    .frame(width: 28, height: 30)
                                                    .scaledToFit()
                                            }
                                            
                                            Text("세이프박스")
                                                .font(.haruchi(.button12))
                                                .foregroundColor(Color.gray7)
                                            
                                            Spacer()
                                            
                                            Text("\(budgetViewModel.safeBox)원")
                                                .font(.haruchi(.body_r16))
                                                .foregroundColor(Color.black)
                                        }
                                        .padding(.horizontal, 10)
                                    }
                            }
                            .padding(.top, 25)
                            Spacer()
                        }
                    }
                }
                .refreshable {
                            // 새로고침 시 실행할 코드
                            setupView()
                        }
                .onAppear {
                    if !hasLoaded { setupView() }
                }
                
                
            }
        }
    }
    
}
