//
//  BudgetMainView.swift
//  HARUCHI
//
//  Created by 이상엽 on 7/23/24.
//

import SwiftUI

struct BudgetMainView : View {
    
    @EnvironmentObject var BudgetviewModel : BudgetMainViewModel
    
    
    @State private var navigateToNextView = false
    
 
    
    
    
    var body: some View {
        NavigationView{
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
                                BudgetviewModel.isFirstButtonActive = true
                            }) {
                                Text("넘기기")
                                    .frame(width: 119, height: 10)
                                    .font(.haruchi(.body_sb16))
                                    .padding()
                                    .background(BudgetviewModel.isFirstButtonActive ? Color.white : Color.sub3Blue)
                                    .foregroundColor(Color.black)
                                    .cornerRadius(17)
                                
                            }
                            Spacer()
                            Button(action: {
                                BudgetviewModel.isFirstButtonActive = false
                            }) {
                                Text("당겨쓰기")
                                    .frame(width: 119, height: 10)
                                    .font(.haruchi(.body_sb16))
                                    .padding()
                                    .background(BudgetviewModel.isFirstButtonActive ? Color.sub3Blue : Color.white)
                                    .foregroundColor(Color.black)
                                    .cornerRadius(17)
                                
                                
                            }
                            Spacer()
                        }//HStack
                        
                        
                    }//ZStack
                    .padding(.top, 20)
                    
                    if BudgetviewModel.isFirstButtonActive {
                        VStack{
                            HStack{
                                Text("이날로")
                                    .font(.haruchi(.body_m14))
                                    .foregroundColor(Color.gray5)
                                Spacer()
                                Button(action: {
                                    BudgetviewModel.showOverlayPush.toggle()
                                }){
                                    HStack{
                                        Text(BudgetviewModel.changableTextPush)
                                            .font(.haruchi(.body_m14))
                                            .foregroundColor(Color.black)
                                        Image(systemName: "chevron.down")
                                            .foregroundColor(Color.gray5)
                                    }
                                }
                            }.padding(.top, 21)//HStack
                            if BudgetviewModel.showOverlayPush {
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
                                                BudgetviewModel.changableTextPush = "고르게 넘기기"
                                            }) {
                                                Text("고르게 넘기기")
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
                                                BudgetviewModel.changableTextPush = "세이프박스"
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
                                    BudgetviewModel.showOverlayPull.toggle()
                                }){
                                    HStack{
                                        Text(BudgetviewModel.changableTextPull)
                                            .font(.haruchi(.body_m14))
                                            .foregroundColor(Color.black)
                                        Image(systemName: "chevron.down")
                                            .foregroundColor(Color.gray5)
                                    }
                                }
                            }.padding(.top, 21)//HStack
                            if BudgetviewModel.showOverlayPull {
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
                                                BudgetviewModel.changableTextPull = "고르게 가져오기"
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
                                                BudgetviewModel.changableTextPull = "세이프박스"
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
                    // Hidden NavigationLink
                    NavigationLink(destination: BudgetPullPushView().navigationBarBackButtonHidden(true) // 기본 백 버튼 숨김
                        .navigationBarItems(leading: CustomBackButton()), isActive: $navigateToNextView) {
                        EmptyView()//EmptyView()를 사용하여 NavigationLink를 보이지 않게 만들고 .hidden()으로 숨겨
                    }
                    .hidden()
                }//scrollView
                .scrollIndicators(.hidden) // 스크롤 바를 숨기도록 설정
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        KeypadButton(
                            text: BudgetviewModel.isFirstButtonActive ? "넘기기" :"당겨쓰기",
                            enable: !BudgetviewModel.moneyText.isEmpty,
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

#Preview {
    BudgetMainView()
}
