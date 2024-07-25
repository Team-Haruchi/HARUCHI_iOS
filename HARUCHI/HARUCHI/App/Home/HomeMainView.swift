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
            HStack {
                Image("HomeLogo")
                Image("HomeAlarm")
            }
            .padding(.top, 54)
            .padding(.horizontal, 24)
            
            // 월
            Text("6월")
            
            // 예산
            VStack {
                HStack {
                    Text("한 달 예산")
                    
                    Text("수정")
                }
                
                Text("70000원")
            }
            
            // 그래프
            PercentageBar(viewModel: percent)
            
            // 수입 - 지출
            RoundedRectangle(cornerRadius: 10)
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
            
            // 지출마감
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.gray1)
                .overlay {
                    HStack {
                        Image("HomeClock")
                        
                        Text("오늘 지출을 마감하세요")
                        
                        Text("지출 마감하기")
                    }
                }
            
            
            // 달력 나중에 넣기
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.gray6)
                .frame(width: 338, height: 128)
            
            // 세이프박스
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.gray1)
                .overlay {
                    HStack {
                        Image("HomeCoin")
                        
                        Text("세이프박스")
                        
                        Text("7000원")
                    }
                }
        }
    }
}

#Preview {
    HomeMainView()
}
