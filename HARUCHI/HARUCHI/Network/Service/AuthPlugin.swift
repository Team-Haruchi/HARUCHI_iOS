//
//  AuthPlugin.swift
//  HARUCHI
//
//  Created by 채리원 on 8/17/24.
//

import Foundation
import Moya

struct AuthPlugin: PluginType {
    let token: String

    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var request = request
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return request
    }
}
