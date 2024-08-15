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
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .dailyBudgetCheck(let accessToken):
            return ["Authorization": "Bearer \(accessToken)"]
            
        case .dateBudgetCheck:
            return nil
            
        case .safeBoxCheck(let accessToken):
            return ["Authorization": "Bearer \(accessToken)"]
        }
    }
    
    
}
