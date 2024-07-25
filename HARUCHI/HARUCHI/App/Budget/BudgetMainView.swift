//
//  BudgetMainView.swift
//  HARUCHI
//
//  Created by 이상엽 on 7/23/24.
//

import SwiftUI

struct BudgetMainView : View {
    
    @StateObject private var percent = BudgetPercentage()
    @ObservedObject private var BudgetviewModel = BudgetMainViewModel()
    @State private var isFirstButtonActive: Bool = false
    @State private var showOverlayPush = false //넘기기 옵션선택
    @State private var showOverlayFull = false //당겨쓰기 옵션 선택
    @State private var changableTextPush = "선택해주세요"
    @State private var changableTextFull = "선택해주세요"


    
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Image("haruchiLogoBold1")
                Spacer()
                Button(action:{
                    
                }){
                    Image("notification")
                        .frame(width: 30, height: 30)
                }
            }//HStack
            ScrollView{
                
                
                RoundedRectangle(cornerRadius: 8)
                    .frame(width: 345, height: 378)
                    .foregroundColor(Color.sub3Blue)
                    .padding(.top, 15)
                
                ZStack{
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: 345, height: 55)
                        .foregroundColor(Color.sub3Blue)
                    
                    HStack {
                        Spacer()
                        Button(action: {
                            isFirstButtonActive = true
                        }) {
                            Text("넘기기")
                                .frame(width: 119, height: 10)
                                .font(.haruchi(.body_sb16))
                                .padding()
                                .background(isFirstButtonActive ? Color.white : Color.sub3Blue)
                                .foregroundColor(Color.black)
                                .cornerRadius(17)
                            
                        }
                        Spacer()
                        Button(action: {
                            isFirstButtonActive = false
                        }) {
                            Text("당겨쓰기")
                                .frame(width: 119, height: 10)
                                .font(.haruchi(.body_sb16))
                                .padding()
                                .background(isFirstButtonActive ? Color.sub3Blue : Color.white)
                                .foregroundColor(Color.black)
                                .cornerRadius(17)
                            
                            
                        }
                        Spacer()
                    }//HStack
                    
                    
                }//ZStack
                .padding(.top, 20)
                
                if isFirstButtonActive {
                    VStack{
                        HStack{
                            Text("이날로")
                                .font(.haruchi(.body_m14))
                                .foregroundColor(Color.gray5)
                            Spacer()
                            Button(action: {
                                showOverlayPush.toggle()
                            }){
                                HStack{
                                    Text(changableTextPush)
                                        .font(.haruchi(.body_m14))
                                        .foregroundColor(Color.black)
                                    Image(systemName: "chevron.down")
                                        .foregroundColor(Color.gray5)
                                }
                            }
                        }.padding(.top, 21)//HStack
                        if showOverlayPush {
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
                                            changableTextPush = "고르게 가져오기"
                                        }) {
                                            Text("고르게 가져오기")
                                                .font(.system(size: 14)) // Custom font can be used here
                                                .foregroundColor(Color.gray5)
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
                                            changableTextPush = "세이프박스"
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
                            Text("이날에서")
                                .font(.haruchi(.body_m14))
                                .foregroundColor(Color.gray5)
                            
                            Spacer()
                            Text("선택해주세요")
                                .font(.haruchi(.body_m14))
                                .foregroundColor(Color.gray5)
                        }.padding(.top, 21)
                        HStack{
                            Text("이만큼")
                                .font(.haruchi(.body_m14))
                                .foregroundColor(Color.gray5)
                            Spacer()
                            TextField("입력해주세요", text: $BudgetviewModel.moneyText)
                                .font(.haruchi(.body_m14))
                                .foregroundColor(Color.black)
                                .keyboardType(.numberPad) //키보드 타입 설정
                                .frame(width: 75)
                            
                        }.padding(.top, 21)
                        
                    }//VStack
                } else {
                    VStack{
                        HStack{
                            Text("이날에서")
                                .font(.haruchi(.body_m14))
                                .foregroundColor(Color.gray5)
                            Spacer()
                            Button(action: {
                                showOverlayFull.toggle()
                            }){
                                HStack{
                                    Text(changableTextFull)
                                        .font(.haruchi(.body_m14))
                                        .foregroundColor(Color.black)
                                    Image(systemName: "chevron.down")
                                        .foregroundColor(Color.gray5)
                                }
                            }
                        }.padding(.top, 21)//HStack
                        if showOverlayFull {
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
                                            changableTextFull = "고르게 가져오기"
                                        }) {
                                            Text("고르게 가져오기")
                                                .font(.system(size: 14)) // Custom font can be used here
                                                .foregroundColor(Color.gray5)
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
                                            changableTextFull = "세이프박스"
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
                            Text("이날로")
                                .font(.haruchi(.body_m14))
                                .foregroundColor(Color.gray5)
                            
                            Spacer()
                            Text("선택해주세요")
                                .font(.haruchi(.body_m14))
                                .foregroundColor(Color.gray5)
                        }.padding(.top, 21)
                        HStack{
                            Text("이만큼")
                                .font(.haruchi(.body_m14))
                                .foregroundColor(Color.gray5)
                            Spacer()
                            TextField("입력해주세요", text: $BudgetviewModel.moneyText)
                                .font(.haruchi(.body_m14))
                                .foregroundColor(Color.black)
                                .keyboardType(.numberPad) //키보드 타입 설정
                                .frame(width: 75)
                            
                        }.padding(.top, 21)
                        
                    }//VStack
                }//else
                Spacer()
            }//scrollView
            .scrollIndicators(.hidden) // 스크롤 바를 숨기도록 설정
        }//VStack
        .padding(.leading, 24)
        .padding(.trailing, 24)
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                KeypadButton(
                    text: "당겨쓰기", enable: !BudgetviewModel.moneyText.isEmpty, action: { print("당겨쓰기클릭") }
                )
            }
        }
        
    }
}

#Preview {
    BudgetMainView()
}
