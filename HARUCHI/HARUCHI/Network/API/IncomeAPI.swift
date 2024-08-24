//
//  IncomeAPI.swift
//  HARUCHI
//
//  Created by 채리원 on 8/15/24.
//

import Foundation
import Moya

enum IncomeAPI {
    case income(incomeAmount: Int, category: String) // body
    case incomeDelete(code: Int) // parameters
}

extension IncomeAPI: BaseAPI {
    var path: String {
        switch self {
        case .income:
            return "/daily-budget/income"
  
        case .incomeDelete:
            return "/daily-budget/incone/{incomeId}"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .income:
            return .post
            
        case .incomeDelete:
            return .delete
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .income(let incomeAmount, let category):
            let body = IncomeRequestEntity(incomeAmount: incomeAmount, category: category)
            return .requestJSONEncodable(body)

        case .incomeDelete(let code):
            let param = ["code" : code]
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
        }
    }
}

fileprivate extension IncomeAPI {
    struct IncomeRequestEntity: Encodable {
        let incomeAmount: Int
        let category: String
        
        init(
            incomeAmount: Int,
            category: String
        ) {
            self.incomeAmount = incomeAmount
            self.category = category
        }
    }
}
