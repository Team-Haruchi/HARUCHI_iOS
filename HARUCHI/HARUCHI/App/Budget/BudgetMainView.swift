//
//  BudgetMainView.swift
//  HARUCHI
//
//  Created by 이상엽 on 7/23/24.
//

import SwiftUI

struct BudgetMainView : View {
    
    @EnvironmentObject var budgetViewModel : BudgetMainViewModel
    @State private var navigateToNextView = false
    
    @State private var xOffset: CGFloat = (UIScreen.main.bounds.width - 48) / 4 // 초기값을 "당겨쓰기" 버튼 위치로 설정
    private let buttonWidth = (UIScreen.main.bounds.width - 68) / 2 // 각 버튼의 너비
    
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
                        withAnimation {
                            budgetViewModel.isPushButtonActive = true
                        }
                    }
                Text("당겨쓰기")
                    .foregroundColor(!budgetViewModel.isPushButtonActive ? Color.black : Color.gray5)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .font(.haruchi(.body_sb16))
                    .onTapGesture {
                        withAnimation {
                            budgetViewModel.isPushButtonActive = false
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
        NavigationView {
            VStack(alignment: .leading) {
                HStack{
                    Image("haruchiLogoBold1")
                    Spacer()
                    Button(action:{
                        
                    }){
                        Image("notification")
                            .frame(width: 30, height: 30)
                    }
                }//HStack
                ScrollView {
                    RoundedRectangle(cornerRadius: 8)
                        .frame(height: 378)
                        .foregroundColor(Color.sub3Blue)
                        .padding(.top, 15)
                    
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
                                    Text(budgetViewModel.activeMethodStr())
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
                                            .font(.system(size: 14)) // Custom font can be used here
                                            .foregroundColor(Color.gray5)
                                        Spacer()
                                        Button(action: {
                                            if budgetViewModel.isPushButtonActive {
                                                budgetViewModel.pushMethod = .split
                                            } else {
                                                budgetViewModel.pullMethod = .split
                                            }
                                        }) {
                                            Text(budgetViewModel.isPushButtonActive ? "고르게 넘기기" : "고르게 당겨쓰기")
                                                .font(.system(size: 14)) // Custom font can be used here
                                                .foregroundColor(Color.gray5)
                                                .animation(nil)
                                        }
                                    }
                                    Spacer()
                                    Divider()
                                    HStack {
                                        Text("₩ 70,000")
                                            .font(.system(size: 14)) // Custom font can be used here
                                            .foregroundColor(Color.gray5)
                                        Spacer()
                                        Button(action: {
                                            if budgetViewModel.isPushButtonActive {
                                                budgetViewModel.pushMethod = .safebox
                                            } else {
                                                budgetViewModel.pullMethod = .safebox
                                                
                                            }
                                        }) {
                                            Text("세이프박스")
                                                .font(.system(size: 14)) // Custom font can be used here
                                                .foregroundColor(Color.gray5)
                                        }
                                    }
                                    Spacer()
                                }
                                .padding()
                            }
                        }
                        HStack{
                            Text(budgetViewModel.isPushButtonActive ? "이날에서" : "이날로")
                                .font(.haruchi(.body_m14))
                                .foregroundColor(Color.gray5)
                                .animation(nil)
                            
                            Spacer()
                            Text("선택해주세요")
                                .font(.haruchi(.body_m14))
                                .foregroundColor(Color.gray5)
                        }
                        .padding(.top, 21)
                        
                        HStack {
                            Text("이만큼")
                                .font(.haruchi(.body_m14))
                                .foregroundColor(Color.gray5)
                            Spacer()
                            TextField("입력해주세요", text: $budgetViewModel.money)
                                .font(.haruchi(.body_m14))
                                .foregroundColor(Color.black)
                                .keyboardType(.numberPad) //키보드 타입 설정
                                .frame(width: 75)
                            
                        }
                        .padding(.top, 21)
                        
                    }//VStack
                    .padding(.bottom, 84)
                    
                    Spacer()
                    
                    NavigationLink(destination: BudgetPullPushView() // 기본 백 버튼 숨김
                        , isActive: $navigateToNextView) {
                            EmptyView()//EmptyView()를 사용하여 NavigationLink를 보이지 않게 만들고 .hidden()으로 숨겨
                        }
                        .hidden()
                }//scrollView
                .scrollIndicators(.hidden) // 스크롤 바를 숨기도록 설정
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        KeypadButton(
                            text: budgetViewModel.isPushButtonActive ? "넘기기" :"당겨쓰기",
                            enable: !budgetViewModel.money.isEmpty,
                            action: {
                                navigateToNextView = true
                            }
                        )
                    }
                }
            }//VStack
            .padding(.leading, 24)
            .padding(.trailing, 24)
            
        }//NavigationView
    }
}
