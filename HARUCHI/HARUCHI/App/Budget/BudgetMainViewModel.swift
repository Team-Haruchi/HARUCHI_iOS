//
//  BudgetMainViewModel.swift
//  HARUCHI
//
//  Created by 이상엽 on 7/24/24.
//

import SwiftUI
import Combine

enum Budget {
    enum Push: String {
        case safebox = "세이프박스"
        case split = "고르게 넘기기"
    }
    
    enum Pull: String {
        case safebox = "세이프박스"
        case split = "고르게 당겨쓰기"
    }
}

class BudgetMainViewModel: ObservableObject {
    @Published var isPushButtonActive: Bool = false
    @Published var money = ""
    
    @Published var pushMethod: Budget.Push?
    @Published var pullMethod: Budget.Pull?
    
    @Published var showOverlayPush = false //넘기기 옵션선택
    @Published var showOverlayPull = false //당겨쓰기 옵션 선택
    
    func activeMethodStr() -> String {
        if isPushButtonActive {
            return pushMethod?.rawValue ?? "선택해주세요"
        } else {
            return pullMethod?.rawValue ?? "선택해주세요"
        }
    }
}
