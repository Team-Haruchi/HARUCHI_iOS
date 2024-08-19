//
//  ExpenditureAPI.swift
//  HARUCHI
//
//  Created by 채리원 on 8/15/24.
//

import Foundation
import Moya

enum ExpenditureAPI {
    case expenditure(expenditureAmount: Int, category: String) // body
    
    case expenditureDelete(code: Int) // parameters
}

extension ExpenditureAPI: BaseAPI {
    var path: String {
        switch self {
        case .expenditure:
            return "/daily-budget/expeenditure"

        case .expenditureDelete:
            return "/daily-budget/expenditure/{expenditureId}"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .expenditure:
            return .post
            
        case .expenditureDelete:
            return .delete
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .expenditure(let expenditureAmount, let category):
            let body = ExpenditureRequestEntity(expenditureAmount: expenditureAmount, category: category)
            return .requestJSONEncodable(body)

        case .expenditureDelete(let code):
            let param = ["code" : code]
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
        }
    }
}
    
    fileprivate extension ExpenditureAPI {
        struct ExpenditureRequestEntity: Encodable {
            let expenditureAmount: Int?
            let category: String?
            
            init(
                expenditureAmount: Int? = nil,
                category: String? = nil
            ) {
                self.expenditureAmount = expenditureAmount
                self.category = category
            }
        }
    }
