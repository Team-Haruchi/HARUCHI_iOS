//
//  HomeMainView.swift
//  HARUCHI
//
//  Created by 채리원 on 7/23/24.
//

import SwiftUI
import Combine

struct HomeMainView: View {
    @ObservedObject private var viewModel = OnboardingViewModel() // 예산 데이터 받기
    @StateObject private var percent = BudgetPercentage()
    
    var body: some View {
        GeometryReader { geometry in
            NavigationStack {
                ScrollView {
                    VStack(spacing: 0) {
                        VStack(spacing: 0) {
                            HStack {
                                Image("HomeLogo")
                                
                                Spacer()
                                
                                Image("HomeAlarm")
                            }
                        }
                        .padding(.horizontal, 24)
                        .padding(.top, 6)
                        .padding(.bottom, 25)
                        
                        
                        VStack(alignment: .leading, spacing: 20) {
                            
                            Text("6월")
                                .font(.haruchi(.h2))
                            
                            HStack {
                                Text("한 달 예산")
                                
                                Spacer()
                                
                                Text("수정")
                            }
                            .font(.haruchi(.button14))
                            .foregroundColor(Color.gray6)
                            
                            HStack(spacing: 0) {
                                Text(viewModel.budget)
                                
                                Text("원")
                            }
                            .font(.haruchi(.h1))
                        }
                        .padding(.horizontal, 24)
                        
                        PercentageBar(viewModel: percent)
                            .padding(.top, 16)
                        
                        VStack(spacing: 0) {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.sub3Blue)
                                .frame(width: 345, height: 120)
                                .overlay (
                                    
                                    VStack(spacing: 0) {
                                        Text("15일 목요일")
                                            .font(.haruchi(.body_r16))
                                            .foregroundColor(Color.black)
                                            .padding(.leading, 22)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        
                                        Spacer()
                                        
                                        HStack {
                                            Spacer()
                                            Text("하루치 20000원")
                                                .font(.haruchi(.h2))
                                                .foregroundColor(Color.gray5)
                                            
                                            
                                            NavigationLink(destination: HomeSpendView()) {
                                                Image(systemName: "plus")
                                                    .font(.system(size: 16, weight: .bold))
                                                    .frame(width: 30, height: 30)
                                                    .foregroundColor(Color.mainBlue)
                                                    .background(Circle().fill(Color.white))
                                            }
                                        }
                                        .padding(.horizontal, 22)
                                        Rectangle()
                                            .foregroundColor(Color.gray5)
                                            .frame(height: 2)
                                            .padding(.top, 7)
                                            .padding(.bottom, 9)
                                            .padding(.horizontal, 22)
                                    }
                                        .padding(.vertical, 19)
                                )
                        }
                        .padding(.top, 20)

                        VStack(spacing: 0) {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.gray1)
                                .frame(width: 346, height: 58)
                                .overlay {
                                    HStack {
                                        ZStack {
                                            Circle()
                                                .frame(width: 42, height: 42)
                                                .foregroundColor(Color.white)
                                            
                                            Image("HomeClock")
                                                .frame(width: 28, height: 30)
                                                .scaledToFit()
                                        }
                                        
                                        Text("오늘 지출을 마감하세요")
                                            .font(.haruchi(.button12))
                                            .foregroundColor(Color.gray7)
                                        
                                        Spacer()
                                        
                                        Text("지출 마감하기")
                                            .font(.haruchi(.body_r16))
                                            .foregroundColor(Color.black)
                                        
                                        Image(systemName: "chevron.right")
                                            .foregroundColor(Color.black)
                                    }
                                    .padding(.horizontal, 10)
                                }
                            
                        }
                        .padding(.top, 20)
                        
                        
                        VStack(spacing: 0) {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.gray6)
                                .frame(width: 345, height: 128)
                        }
                        .padding(.top, 25)
                        
                        
                        VStack(spacing: 0) {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.gray1)
                                .frame(width: 345, height: 58)
                                .overlay {
                                    HStack {
                                        ZStack {
                                            Circle()
                                                .frame(width: 42, height: 42)
                                                .foregroundColor(Color.white)
                                            
                                            Image("HomeCoin")
                                                .frame(width: 28, height: 30)
                                                .scaledToFit()
                                        }
                                        
                                        Text("세이프박스")
                                            .font(.haruchi(.button12))
                                            .foregroundColor(Color.gray7)
                                        
                                        Spacer()
                                        
                                        Text("7000원")
                                            .font(.haruchi(.body_r16))
                                            .foregroundColor(Color.black)
                                    }
                                    .padding(.horizontal, 10)
                                }
                        }
                        .padding(.top, 25)
                        Spacer()
                    }
                }
            }
        }
    }
}

#Preview {
    HomeMainView()
}
