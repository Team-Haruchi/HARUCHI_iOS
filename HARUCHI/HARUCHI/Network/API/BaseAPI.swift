//
//  BaseAPI.swift
//  HARUCHI
//
//  Created by 이건우 on 8/9/24.
//

import Foundation
import Moya

protocol BaseAPI: TargetType { }

extension BaseAPI {
    public var baseURL: URL {
        guard let baseURL = Bundle.main.infoDictionary?["API_BASE_URL"] as? String else {
            return URL(string: "dummy")!
        }
        
        return URL(string: baseURL)!
    }
    
    public var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
