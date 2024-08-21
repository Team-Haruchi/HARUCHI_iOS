//
//  CloseAPI.swift
//  HARUCHI
//
//  Created by 채리원 on 8/19/24.
//

import Foundation
import Moya

enum CloseAPI {
    case closeReceipt(year: Int, month: Int, day: Int) // body
    case closeBudget(redistributionOption: String, year: Int, month: Int, day: Int) // parameters
    case closeAmount(year: Int, month: Int, day: Int) // parameters
}

extension CloseAPI: BaseAPI {
    var path: String {
        switch self {
        case .closeReceipt, .closeBudget:
            return "/budget-redistribution/closing"
        
        case .closeAmount:
            return "/budget-redistribution/closing/amount"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .closeBudget:
            return .post
        
        case .closeReceipt, .closeAmount:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .closeReceipt(let year, let month, let day):
            let params = ["year": year, "month": month, "day": day]
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
            
        case .closeBudget(let redistributionOption, let year, let month, let day):
            let body = CloseRequestEntity(redistributionOption: redistributionOption, year: year, month: month, day: day)
            return .requestJSONEncodable(body)

        case .closeAmount(let year, let month, let day):
            let params = ["year": year, "month": month, "day": day]
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        }
    }
}
    
fileprivate extension CloseAPI {
    struct CloseRequestEntity: Encodable {
        let redistributionOption: String?
        let year: Int?
        let month: Int?
        let day: Int?
        
        init(
            redistributionOption: String? = nil,
            year: Int? = nil,
            month: Int? = nil,
            day: Int? = nil
        ) {
            self.redistributionOption = redistributionOption
            self.year = year
            self.month = month
            self.day = day
        }
    }
}
