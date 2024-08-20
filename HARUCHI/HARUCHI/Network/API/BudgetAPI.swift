//
//  BudgetAPI.swift
//  HARUCHI
//
//  Created by 이상엽 on 8/13/24.
//

import Foundation
import Moya

enum BudgetAPI {
    case dailyBudgetCheck
    case dateBudgetCheck
    case safeBoxCheck
    case monthlyBudgetCheck
    case leftNowCheck
    case budgetPercentCheck
    case weekBudgetCheck

}

extension BudgetAPI: BaseAPI {
    var path: String {
        switch self {
        case .dailyBudgetCheck:
            return "/daily-budget"
            
        case .dateBudgetCheck:
            return "/daily-budget/list"
            
        case .safeBoxCheck:
            return "/member/safebox"
            
        case .monthlyBudgetCheck:
            return "/monthly-budget/"
            
        case .leftNowCheck:
            return "/monthly-budget/left-now"
            
        case .budgetPercentCheck:
            return "/monthly-budget/percent"
            
        case .weekBudgetCheck:
            return "/monthly-budget/week"
            
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .dailyBudgetCheck:
            return .get
            
        case .dateBudgetCheck:
            return .get
            
        case .safeBoxCheck:
            return .get
            
        case .monthlyBudgetCheck:
            return .get
            
        case .leftNowCheck:
            return .get
            
        case .budgetPercentCheck:
            return .get
            
        case .weekBudgetCheck:
            return .get
            
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .dailyBudgetCheck:
            return .requestPlain
            
        case .dateBudgetCheck:
            return .requestPlain
            
        case .safeBoxCheck:
            return .requestPlain
            
        case .monthlyBudgetCheck:
            return .requestPlain
            
        case .leftNowCheck:
            return .requestPlain
            
        case .budgetPercentCheck:
            return .requestPlain
            
        case .weekBudgetCheck:
            return .requestPlain
            
        }
    }
}
