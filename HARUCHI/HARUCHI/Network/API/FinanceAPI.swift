//
//  FinanceAPI.swift
//  HARUCHI
//
//  Created by 채리원 on 8/12/24.
//

import Foundation
import Moya

enum FinanceAPI {
    case income(incomeAmount: Int, category: String) // body
    case expenditure(expenditureAmount: Int, category: String) // body
    
    case incomeDelete(code: Int) // parameters
    case expenditureDelete(code: Int) // parameters
}

extension FinanceAPI: BaseAPI {
    var path: String {
        switch self {
        case .income:
            return "/daily-budget/income"
        case .expenditure:
            return "/daily-budget/expeenditure"
            
        case .incomeDelete:
            return "/daily-budget/incone/{incomeId}"
        case .expenditureDelete:
            return "/daily-budget/expenditure/{expenditureId}"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .income, .expenditure:
            return .post
            
        case .incomeDelete, .expenditureDelete:
            return .delete
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .income(let incomeAmount, let category):
            let body = FinanceRequestEntity(incomeAmount: incomeAmount, category: category)
            return .requestJSONEncodable(body)
        case .expenditure(let expenditureAmount, let category):
            let body = FinanceRequestEntity(expenditureAmount: expenditureAmount, category: category)
            return .requestJSONEncodable(body)
        case .incomeDelete(let code):
            let param = ["code" : code]
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
        case .expenditureDelete(let code):
            let param = ["code" : code]
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
        }
    }
}
    
    fileprivate extension FinanceAPI {
        struct FinanceRequestEntity: Encodable {
            let incomeAmount: Int?
            let expenditureAmount: Int?
            let category: String?
            
            init(
                incomeAmount: Int? = nil,
                expenditureAmount: Int? = nil,
                category: String? = nil
            ) {
                self.incomeAmount = incomeAmount
                self.expenditureAmount = expenditureAmount
                self.category = category
            }
        }
    }
