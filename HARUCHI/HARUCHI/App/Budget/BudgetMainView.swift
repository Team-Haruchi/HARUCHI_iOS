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
    @State private var text: String = ""

    
    
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
                    Text("First Button is Active")
                        .font(.largeTitle)
                        .foregroundColor(.blue)
                } else {
                    VStack{
                        HStack{
                            Text("이날에서")
                                .font(.haruchi(.body_m14))
                                .foregroundColor(Color.gray5)
                            Spacer()
                            Button(action: {
                                
                            }){
                                HStack{
                                    Text("고르게 가져오기")
                                        .font(.haruchi(.body_m14))
                                        .foregroundColor(Color.black)
                                    Image(systemName: "chevron.down")
                                        .foregroundColor(Color.gray5)
                                }
                            }
                        }.padding(.top, 21)//HStack
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
