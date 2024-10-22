//
//  BudgetMainView.swift
//  HARUCHI
//
//  Created by 이상엽 on 7/23/24.
//

import SwiftUI

struct BudgetMainView : View {
    
    @EnvironmentObject var budgetViewModel : BudgetMainViewModel
    @EnvironmentObject var calendarViewModel : CalendarViewModel
    @State private var navigateToNextView = false
    
    @FocusState private var isFocused: Bool
    @State private var xOffset: CGFloat = (UIScreen.main.bounds.width - 48) / 4
    private let buttonWidth = (UIScreen.main.bounds.width - 68) / 2
    
    @State private var hasLoaded: Bool = false
        
        private func setupView() {
            budgetViewModel.loadSafeBox()
            budgetViewModel.refreshData()
            calendarViewModel.fetchCalendarData()
            hasLoaded = true
        }
    
    
    var bubbleRadioButton: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.sub3Blue)
                .frame(width: UIScreen.main.bounds.width - 48, height: 55)
            
            HStack(spacing: 0) {
                Text("넘기기")
                    .foregroundColor(budgetViewModel.isPushButtonActive ? Color.black : Color.gray5)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .font(.haruchi(.body_sb16))
                    .onTapGesture {
                        budgetViewModel.pullMethod = .none
                        withAnimation {
                            budgetViewModel.isPushButtonActive = true
                            budgetViewModel.isBoxButtonActive = false
                        }
                    }
                Text("당겨쓰기")
                    .foregroundColor(!budgetViewModel.isPushButtonActive ? Color.black : Color.gray5)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .font(.haruchi(.body_sb16))
                    .onTapGesture {
                        budgetViewModel.pushMethod = .none
                        withAnimation {
                            budgetViewModel.isPushButtonActive = false
                            budgetViewModel.isBoxButtonActive = false
                        }
                    }
            }
            .frame(width: UIScreen.main.bounds.width - 48, height: 55)
            .background(
                RoundedRectangle(cornerRadius: 17)
                    .fill(Color.white)
                    .frame(width: buttonWidth, height: 45)
                    .offset(x: budgetViewModel.isPushButtonActive ? -buttonWidth / 2 : buttonWidth / 2)
                    .animation(.easeIn(duration: 0.2), value: xOffset)
            )
        }
        .onChange(of: budgetViewModel.isPushButtonActive, {
            xOffset = budgetViewModel.isPushButtonActive ? -buttonWidth / 2 : buttonWidth / 2
        })
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                HStack{
                    Image("mainLogo")
                        .resizable()
                        .frame(width: 111, height: 14)
                    Spacer()
                    //                    Button(action:{ 알림창 미구현
                    //
                    //                    }){
                    //                        Image("notification")
                    //                            .frame(width: 30, height: 30)
                    //                    }
                }
                .padding(.top, 16)
                .padding(.bottom, 15)
                
                ScrollView {
                    FSCalendarView(viewModel: calendarViewModel)
                        .frame(width: 345, height: 380)
                    
                    bubbleRadioButton
                        .padding(.top, 20)
                    
                    VStack {
                        HStack {
                            Text(budgetViewModel.isPushButtonActive ? "이날로" : "이날에서")
                                .font(.haruchi(.body_m14))
                                .foregroundColor(Color.gray5)
                                .animation(nil)
                            
                            Spacer()
                            
                            Button(action: {
                                budgetViewModel.showOverlayPush.toggle()
                            }){
                                HStack {
                                    let dates = calendarViewModel.selectedDates()
                                    Text(budgetViewModel.isBoxButtonActive ? budgetViewModel.activeMethodStr() : "\(calendarViewModel.dateString(from: dates.1))")
                                        .font(.haruchi(.body_m14))
                                        .foregroundColor(Color.black)
                                        .animation(nil)
                                    Image(systemName: "chevron.down")
                                        .foregroundColor(Color.gray5)
                                }
                            }
                        }
                        .padding(.top, 21)//HStack
                        
                        if budgetViewModel.showOverlayPush {
                            ZStack {
                                Rectangle()
                                    .frame(width: 345, height: 107)
                                    .border(Color.gray5, width: 0.5)
                                    .foregroundColor(Color.white)
                                VStack {
                                    Spacer()
                                    HStack {
                                        Text("남은 일수에서 1/n")
                                            .font(.system(size: 14))
                                            .foregroundColor(Color.gray5)
                                        Spacer()
                                        Button(action: {
                                            budgetViewModel.isBoxButtonActive = true
                                            if budgetViewModel.isPushButtonActive {
                                                budgetViewModel.pushMethod = .split
                                            } else {
                                                budgetViewModel.pullMethod = .split
                                            }
                                        }) {
                                            Text(budgetViewModel.isPushButtonActive ? "고르게 넘기기" : "고르게 당겨쓰기")
                                                .font(.system(size: 14))
                                                .foregroundColor(Color.gray5)
                                                .animation(nil)
                                        }
                                    }
                                    Spacer()
                                    Divider()
                                    HStack {
                                        Text("₩ \(budgetViewModel.safeBox)")
                                            .font(.system(size: 14))
                                            .foregroundColor(Color.gray5)
                                        Spacer()
                                        Button(action: {
                                            budgetViewModel.isBoxButtonActive = true
                                            if budgetViewModel.isPushButtonActive {
                                                budgetViewModel.pushMethod = .safebox
                                            } else {
                                                budgetViewModel.pullMethod = .safebox
                                            }
                                        }) {
                                            Text("세이프박스")
                                                .font(.system(size: 14))
                                                .foregroundColor(Color.gray5)
                                        }
                                    }
                                    Spacer()
                                }
                                .padding()
                            }
                        }
                        HStack {
                            Text(budgetViewModel.isPushButtonActive ? "이날에서" : "이날로")
                                .font(.haruchi(.body_m14))
                                .foregroundColor(Color.gray5)
                                .animation(nil)
                            
                            Spacer()
                            let dates = calendarViewModel.selectedDates()
                            Text("\(calendarViewModel.dateString(from: dates.0))" )
                                .font(.haruchi(.body_m14))
                                .foregroundColor(Color.black)

                        }
                        .padding(.top, 21)
                        
                        HStack {
                            Text("이만큼")
                                .font(.haruchi(.body_m14))
                                .foregroundColor(Color.gray5)
                            Spacer()
                            TextField("입력해주세요", text: $budgetViewModel.pullPushBudget)
                                .font(.haruchi(.body_m14))
                                .foregroundColor(Color.black)
                                .keyboardType(.numberPad)
                                .frame(width: 75)
                                .focused($isFocused)
                            
                        }
                        .padding(.top, 21)
                        
                    }//VStack
                    .onTapGesture {
                        isFocused = false
                    }
                    .padding(.bottom, 84)
                    
                    Spacer()
                    
                    Button("Go to BudgetPullPushView") {
                        navigateToNextView = true
                    }
                    .hidden()
                    .navigationDestination(isPresented: $navigateToNextView) {
                        BudgetPullPushView()
                            .environmentObject(budgetViewModel)
                            .environmentObject(calendarViewModel)
                    }
                }//scrollView
                .refreshable {
                            // 새로고침 시 실행할 코드
                            setupView()
                        }
                .scrollIndicators(.hidden)
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        KeypadButton(
                            text: budgetViewModel.isPushButtonActive ? "넘기기" :"당겨쓰기",
                            enable: !budgetViewModel.pullPushBudget.isEmpty /*&& (budgetViewModel.pushMethod != .none || budgetViewModel.pullMethod != .none)*/,
                            action: {
                                if let firstDate = calendarViewModel.selectedDates().0 {
                                    budgetViewModel.firstDate = firstDate
                                }
                                if let secondDate = calendarViewModel.selectedDates().1 {
                                    budgetViewModel.secondDate = secondDate
                                }
                                navigateToNextView = true
                            }
                        )
                    }
                }
            }
            .onAppear {
                if !hasLoaded { setupView() }
            }
            
            
            .padding(.leading, 24)
            .padding(.trailing, 24)
            
        }
    }
}
