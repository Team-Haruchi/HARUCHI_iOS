//
//  BudgetPullPushView.swift
//  HARUCHI
//
//  Created by 이상엽 on 7/26/24.
//

import SwiftUI


struct BudgetPullPushView: View {
    
    @EnvironmentObject var BudgetviewModel : BudgetMainViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
            VStack(spacing: 0){
                Image("haruchiSimbol1")
                    .padding(.top, 194)
                if BudgetviewModel.isFirstButtonActive == true { // ########넘기기########################################
                    HStack(spacing: 0){
                        if BudgetviewModel.changableTextPush == "고르게 넘기기"{
                            Text("고르게")
                                .font(.haruchi(.h1))
                                .foregroundStyle(Color.mainBlue)
                        } else {
                            Text("세이프박스")
                                .font(.haruchi(.h1))
                                .foregroundStyle(Color.mainBlue)
                            Text("로")
                                .font(.haruchi(.h1))
                                .foregroundStyle(Color.black)
                        }
                    } .padding(.top, 30)
                    HStack(spacing: 0){
                        if BudgetviewModel.changableTextPush == "고르게 넘기기"{
                            // 텍스트 필드 입력 값과 정수 변환 후 계산된 값을 표시
                            if let changableInt = Int(BudgetviewModel.moneyText) {
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
                            if let changableInt = Int(BudgetviewModel.moneyText) {
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
                    Text("넘길게요")
                        .font(.haruchi(.h1))
                        .foregroundStyle(Color.black)
                        .padding(.top, 7)
                    Spacer()
                    Button(action:{
                        presentationMode.wrappedValue.dismiss()
                    }){
                        Text("넘기기")
                            .frame(width: 345, height: 45)
                            .font(.haruchi(.button14))
                            .foregroundStyle(Color.white)
                            .background(Color.mainBlue)
                            .cornerRadius(10)
                            .padding(.bottom, 17)
                    }
                        
                    
                } else { // ###################당겨쓰기######################################
                    HStack(spacing: 0){
                        if BudgetviewModel.changableTextPull == "고르게 가져오기"{
                            Text("고르게")
                                .font(.haruchi(.h1))
                                .foregroundStyle(Color.mainBlue)
                        } else {
                            Text("세이프박스")
                                .font(.haruchi(.h1))
                                .foregroundStyle(Color.mainBlue)
                            Text("에서")
                                .font(.haruchi(.h1))
                                .foregroundStyle(Color.black)
                        }
                    } .padding(.top, 30)
                    HStack(spacing: 0){
                        if BudgetviewModel.changableTextPull == "고르게 가져오기" {
                            // 텍스트 필드 입력 값과 정수 변환 후 계산된 값을 표시
                            if let changableInt = Int(BudgetviewModel.moneyText) {
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
                            if let changableInt = Int(BudgetviewModel.moneyText) {
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
                    }//HStack
                    .padding(.top, 7)
                    Text("당겨올게요")
                        .font(.haruchi(.h1))
                        .foregroundStyle(Color.black)
                        .padding(.top, 7)
                    Spacer()
                    Button(action:{
                        presentationMode.wrappedValue.dismiss()
                    }){
                        Text("당겨쓰기")
                            .frame(width: 345, height: 45)
                            .font(.haruchi(.button14))
                            .foregroundStyle(Color.white)
                            .background(Color.mainBlue)
                            .cornerRadius(10)
                            .padding(.bottom, 17)
                    }
                        
                    
                }
//                Button(action:{
//                    print("isFirstButtonActive: \(BudgetviewModel.isFirstButtonActive)")
//                    print("changableTextPull: \(BudgetviewModel.changableTextPull)")
//                    print("changableTextPush: \(BudgetviewModel.changableTextPush)")
//                    print("moneyText: \(BudgetviewModel.moneyText)")
//                }){
//                    Text("test")
//                }
            }//VStack
            
        
    }
}
    

struct CustomBackButton: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "chevron.left")
                    .foregroundStyle(Color.black)
            }
        }
    }
}
