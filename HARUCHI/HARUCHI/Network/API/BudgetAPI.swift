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
    case monthlyBudgetEdit(monthBudget: Int)
    case pushBudget(redistributionOption: String, amount: Int, sourceDay: Int, targetDay: Int?)
    case pullBudget(redistributionOption: String, amount: Int, sourceDay: Int, targetDay: Int)

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
            
        case .monthlyBudgetEdit:
            return "/monthly-budget/"
            
        case .pushBudget:
            return "budget-redistribution/push"
            
        case .pullBudget:
            return "budget-redistribution/pull"
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
            
        case .monthlyBudgetEdit:
            return .patch
            
        case .pushBudget:
            return .post
            
        case .pullBudget:
            return .post
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
            
        case .monthlyBudgetEdit(let monthBudget):
            return .requestParameters(parameters: ["monthBudget": monthBudget], encoding: JSONEncoding.default)
            
        case .pushBudget(redistributionOption: let redistributionOption, amount: let amount, sourceDay: let sourceDay, targetDay: let targetDay):
            let body = RedistributionRequestEntity(redistributionOption: redistributionOption, amount: amount, sourceDay: sourceDay, targetDay: targetDay)
            return .requestJSONEncodable(body)
            
        case .pullBudget(redistributionOption: let redistributionOption, amount: let amount, sourceDay: let sourceDay, targetDay: let targetDay):
            let body = RedistributionRequestEntity(redistributionOption: redistributionOption, amount: amount, sourceDay: sourceDay, targetDay: targetDay)
            return .requestJSONEncodable(body)
        }
    }
}

private extension BudgetAPI {
    struct RedistributionRequestEntity: Encodable {
        let redistributionOption: String
        let amount: Int
        let sourceDay: Int
        let targetDay: Int?
    }
}


