//
//  HomeSpendView.swift
//  HARUCHI
//
//  Created by 채리원 on 7/25/24.
//

import SwiftUI

struct HomeSpendView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var money = ""
    @State private var selectedCategory = "미분류"
    @State private var upSpendSheet = false
    @State private var showMainButton = false
    @State private var selectedType = ""
    
    var body: some View {
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
                    
                    TextField("하루치 20000원", text: $money)
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
                        .foregroundColor(selectedType == category ? Color.black : Color.gray5)
                        .font(selectedType == category ? .haruchi(.body_sb16) : .haruchi(.body_r16))
                        .onTapGesture {
                            selectedType = category
                            if category == "지출" {
                                selectedCategory = "미분류"
                                upSpendSheet = true
                            } else {
                                selectedCategory = category
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
                
                Text(selectedCategory == "미분류" ? "미분류" : selectedCategory)
                    .font(selectedCategory == "미분류" ? .haruchi(.body_r16) : .haruchi(.body_sb16))
                    .foregroundColor(selectedCategory == "미분류" ? Color.gray5 : Color.black)
                Image(systemName: "chevron.right")
            }
            .font(.haruchi(.body_r16))
            .foregroundColor(Color.gray5)
            .frame(width: 345, height: 45)
            .padding(.horizontal, 24)
            .onTapGesture {
                if selectedType == "지출" {
                    upSpendSheet = true
                }
            }
            
            // action 나중에 바꾸기
            if showMainButton {
                MainButton(text: "저장하기", enable: selectedCategory != "미분류", action: {
                    print("ㅇㅋㅇㅋ")
                })
                .padding(.top, 400)
            }
        }
        .sheet(isPresented: $upSpendSheet) {
            SpendSheetView(selectedCategory: $selectedCategory)
            .presentationDragIndicator(.visible)
            .presentationDetents([.medium]) // sheet 크기 반만
        }
        .onChange(of: selectedCategory) { newValue in
            if newValue != "미분류" && newValue != "지출" {
                showMainButton = true
            }
        }
        Spacer()
        
            // 네비게이션바 뒤로가기 버튼 커스텀
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(Color.black)
                    }
                }
                
                ToolbarItemGroup(placement: .keyboard) {
                    KeypadButton(
                        text: "저장하기", enable: !money.isEmpty, action: { print("버튼 눌림 ㅇㅇ") }
                    )
                }
            }
            .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    HomeSpendView()
}
