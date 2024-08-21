//
//  BudgetPullPushView.swift
//  HARUCHI
//
//  Created by 이상엽 on 7/26/24.
//

import SwiftUI


struct BudgetPullPushView: View {
    
    @EnvironmentObject var budgetViewModel : BudgetMainViewModel
    @EnvironmentObject var calendarViewModel : CalendarViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            Image("mainLogo")
                .padding(.top, 194)
            
            HStack(spacing: 0){
                if budgetViewModel.isBoxButtonActive {
                    if budgetViewModel.pushMethod == .split || budgetViewModel.pullMethod == .split {
                        Text("고르게")
                            .font(.haruchi(.h1))
                            .foregroundStyle(Color.mainBlue)
                    } else {
                        Text("세이프박스")
                            .font(.haruchi(.h1))
                            .foregroundStyle(Color.mainBlue)
                        Text(budgetViewModel.isPushButtonActive ? "로" : "에서")
                            .font(.haruchi(.h1))
                            .foregroundStyle(Color.black)
                    }
                } else {
                    let dates = calendarViewModel.selectedDates()
                    Text("\(calendarViewModel.dateString(from: dates.1))")
                        .font(.haruchi(.h1))
                        .foregroundStyle(Color.mainBlue)
                    Text(budgetViewModel.isPushButtonActive ? "로" : "에서")
                        .font(.haruchi(.h1))
                        .foregroundStyle(Color.black)
                }
            }
            .padding(.top, 30)
            
            HStack(spacing: 0) {
                if budgetViewModel.pushMethod == .split {
                    // 텍스트 필드 입력 값과 정수 변환 후 계산된 값을 표시
                    if let changableInt = Int(budgetViewModel.pullPushBudget) {
                        Text("\(changableInt / 30)원")
                            .font(.haruchi(.h1))
                            .foregroundStyle(Color.mainBlue)
                    } else {
                        Text("Invalid input")
                    }
                    
                    Text("씩")
                        .font(.haruchi(.h1))
                        .foregroundStyle(Color.black)
                } else {
                    // 텍스트 필드 입력 값과 정수 변환 후 계산된 값을 표시
                    if let changableInt = Int(budgetViewModel.pullPushBudget) {
                        Text("\(changableInt)원")
                            .font(.haruchi(.h1))
                            .foregroundStyle(Color.mainBlue)
                    } else {
                        Text("Invalid input")
                    }
                    Text("을")
                        .font(.haruchi(.h1))
                        .foregroundStyle(Color.black)
                }
            } .padding(.top, 7)
            Text(budgetViewModel.isPushButtonActive  ? "넘길게요" : "당겨올게요")
                .font(.haruchi(.h1))
                .foregroundStyle(Color.black)
                .padding(.top, 7)
            Spacer()
            Button(action:{
                presentationMode.wrappedValue.dismiss()
            }){
                Text(budgetViewModel.isPushButtonActive  ? "넘기기" : "당겨쓰기")
                    .frame(width: 345, height: 45)
                    .font(.haruchi(.button14))
                    .foregroundStyle(Color.white)
                    .background(Color.mainBlue)
                    .cornerRadius(10)
                    .padding(.bottom, 17)
            }
            
            
            
            
            
            //            Button(action:{
            //                print("isPushButtonActive: \(budgetViewModel.isPushButtonActive)")
            //                //                                print("changableTextPull: \(budgetViewModel.changableTextPull)")
            //                //                                print("changableTextPush: \(budgetViewModel.changableTextPush)")
            //                print("moneyText: \(budgetViewModel.money)")
            //            }){
            //                Text("test")
            //            }
        }//VStack
        .navigationBarBackButtonHidden(true)
        .backButtonStyle()
    }
}


//struct CustomBackButton: View {
//    @Environment(\.presentationMode) var presentationMode
//
//    var body: some View {
//        Button(action: {
//            presentationMode.wrappedValue.dismiss()
//        }) {
//            HStack {
//                Image(systemName: "chevron.left")
//                    .foregroundStyle(Color.black)
//            }
//        }
//    }
//}
