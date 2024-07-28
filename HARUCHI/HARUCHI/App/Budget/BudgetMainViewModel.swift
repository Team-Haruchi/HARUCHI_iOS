//
//  BudgetMainViewModel.swift
//  HARUCHI
//
//  Created by 이상엽 on 7/24/24.
//

import SwiftUI
import Combine

class BudgetMainViewModel: ObservableObject {
    @Published var isFirstButtonActive: Bool = false
    @Published var moneyText = ""
    @Published var changableTextPush = "선택해주세요"
    @Published var changableTextPull = "선택해주세요"
    @Published var showOverlayPush = false //넘기기 옵션선택
    @Published var showOverlayPull = false //당겨쓰기 옵션 선택

}
