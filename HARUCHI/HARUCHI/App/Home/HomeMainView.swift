//
//  HomeMainView.swift
//  HARUCHI
//
//  Created by 채리원 on 7/23/24.
//

import SwiftUI
import Combine

struct HomeMainView: View {
    @StateObject private var percent = BudgetPercentage()
    
    var body: some View {
        VStack(spacing: 0) {
            // 로고, 알림창
            VStack(spacing: 0) {
                HStack {
                    Image("HomeLogo")
                    
                    Spacer()
                    
                    Image("HomeAlarm")
                }
            }
            .padding(.horizontal, 24)
            
            
            // 월, 예산
            VStack(alignment: .leading, spacing: 20) {
                Text("6월")
                    .font(.haruchi(.h2))
                    .padding(.top, 25)

                HStack {
                    Text("한 달 예산")
                    
                    Spacer()
                    
                    Text("수정")
                }
                .font(.haruchi(.button14))
                .foregroundColor(Color.gray6)
                
                Text("70000원")
                    .font(.haruchi(.h1))
            }
            .padding(.horizontal, 24)
            
            // 그래프
            PercentageBar(viewModel: percent)
                .padding(.top, 16)
            
            // 수입 - 지출
            VStack(spacing: 0) {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.sub3Blue)
                    .frame(width: 345, height: 120)
                    .overlay (
                        VStack {
                            Text("15일 목요일")
                                .font(.haruchi(.body_r16))
                                .foregroundColor(Color.black)
                            
                            HStack {
                                Text("하루치 20000원")
                                    .font(.haruchi(.h2))
                                    .foregroundColor(Color.gray5)
                                
                                Button(action: {
                                    // 화면 넘어가는거 나중에 추가
                                }) {
                                    Image(systemName: "plus")
                                        .font(.system(size: 16, weight: .bold))
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(Color.mainBlue)
                                        .background(Circle().fill(Color.white))
                                }
                            }
                            GrayLine()
                        }
                    )
            }
            .padding(.top, 20)
            
            // 지출마감
            VStack(spacing: 0) {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray1)
                    .frame(width: 346, height: 58)
                    .overlay {
                        HStack {
                            Image("HomeClock")
                            
                            Text("오늘 지출을 마감하세요")
                            
                            Text("지출 마감하기")
                        }
                    }
            }
            .padding(.top, 20)
            
            
            // 달력 나중에 넣기
            VStack(spacing: 0) {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray6)
                    .frame(width: 345, height: 128)
            }
            .padding(.top, 25)
            
            
            // 세이프박스
            VStack(spacing: 0) {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray1)
                    .frame(width: 345, height: 58)
                    .overlay {
                        HStack {
                            Image("HomeCoin")
                            
                            Text("세이프박스")
                            
                            Text("7000원")
                        }
                    }
            }
            .padding(.top, 25)
        }
    }
}

#Preview {
    HomeMainView()
}
