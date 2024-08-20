//
//  CloseAPI.swift
//  HARUCHI
//
//  Created by 채리원 on 8/19/24.
//

import Foundation
import Moya

enum CloseAPI {
    case closeRecepit(year: Int, month: Int, day: Int) // body
    case closeBudget(redistributionOption: String, year: Int, month: Int, day: Int) // parameters
    case closeCheck(year: Int, month: Int, day: Int) // parameters
    case closeCheckLast // no parameters
    case closeAmount(year: Int, month: Int, day: Int) // parameters
}

extension CloseAPI: BaseAPI {
    var path: String {
        switch self {
        case .closeRecepit, .closeBudget:
            return "/budget-redistribution/closing"
        
        case .closeCheck:
            return "/budget-redistribution/closing/check"
            
        case .closeCheckLast:
            return "/budget-redistribution/closing/check/last"
            
        case .closeAmount:
            return "/budget-redistribution/closing/amount"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .closeBudget:
            return .post
        
        case .closeRecepit, .closeCheck, .closeCheckLast, .closeAmount:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .closeRecepit(let year, let month, let day):
            let body = CloseRequestEntity(year: year, month: month, day: day)
            return .requestJSONEncodable(body)
            
        case .closeBudget(let redistributionOption, let year, let month, let day):
            let body = CloseRequestEntity(redistributionOption: redistributionOption, year: year, month: month, day: day)
            return .requestJSONEncodable(body)

        case .closeCheck(let year, let month, let day), .closeAmount(let year, let month, let day):
            let param = ["year": year, "month": month, "day": day]
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
        case .closeCheckLast:
            <#code#>
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
