//
//  CloseAPI.swift
//  HARUCHI
//
//  Created by 채리원 on 8/19/24.
//

import Foundation
import Moya

enum CloseAPI {
    case close(redistributionOption: String, year: Int, month: Int, day: Int) // body
    case closeCheck(code: Int) // parameters
    case clodseConfirm(code: Int) // parameters
}

extension CloseAPI: BaseAPI {
    var path: String {
        switch self {
        case .close, .closeCheck:
            return "/budget-redistribution/closing"
        
        case .clodseConfirm:
            return "/budget-redistribution/check"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .close:
            return .post
        
        case .closeCheck, .clodseConfirm:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .close(let redistributionOption, let year, let month, let day):
            let body = CloseRequestEntity(redistributionOption: redistributionOption, year: year, month: month, day: day)
            return .requestJSONEncodable(body)

        case .closeCheck(let code), .clodseConfirm(let code):
            let param = ["code" : code]
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
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
