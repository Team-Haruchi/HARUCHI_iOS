//
//  LoginResponse.swift
//  HARUCHI
//
//  Created by 이건우 on 8/13/24.
//

import Foundation

struct LoginResponse: Decodable {
    let grantType: String
    let accessToken: String
}
