//
//  BudgetAPI.swift
//  HARUCHI
//
//  Created by 이상엽 on 8/13/24.
//

import Foundation
import Moya

enum BudgetAPI {
    case dailyBudgetCheck(accessToken: String)
    case dateBudgetCheck(accessToken: String)
    case safeBoxCheck(accessToken: String)
    case monthlyBudgetCheck(accessToken: String)
    case leftNowCheck(accessToken: String)
    case budgetPercentCheck(accessToken: String)
    case weekBudgetCheck(accessToken: String)

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
    
    var headers: [String : String]? {
        switch self {
        case .dailyBudgetCheck(let accessToken):
            return ["Authorization": "Bearer \(accessToken)"]
            
        case .dateBudgetCheck(let accessToken):
            return ["Authorization": "Bearer \(accessToken)"]
            
        case .safeBoxCheck(let accessToken):
            return ["Authorization": "Bearer \(accessToken)"]
            
        case .monthlyBudgetCheck(let accessToken):
            return ["Authorization": "Bearer \(accessToken)"]
            
        case .leftNowCheck(let accessToken):
            return ["Authorization": "Bearer \(accessToken)"]
            
        case .budgetPercentCheck(let accessToken):
            return ["Authorization": "Bearer \(accessToken)"]
            
        case .weekBudgetCheck(let accessToken):
            return ["Authorization": "Bearer \(accessToken)"]
            
        }
    }
    
    
}
