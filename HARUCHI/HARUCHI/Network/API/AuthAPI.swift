//
//  AuthAPI.swift
//  HARUCHI
//
//  Created by 이건우 on 8/5/24.
//

import Foundation
import Moya

enum AuthAPI {
    case logIn(email: String, password: String) // body
    case logOut(accessToken: String) // param
    
    case signIn(monthBudget: Int, name: String, email: String, password: String) // body
    case emailAuth(email: String) // param
    case emailAuthVerify(email: String, code: String) // param
}

extension AuthAPI: BaseAPI {
    var path: String {
        switch self {
        case .logIn:
            return "/member/login"
        case .logOut:
            return "/member/logout"
        case .signIn:
            return "/member/signup"
        case .emailAuth:
            return "/member/signup/email"
        case .emailAuthVerify:
            return "/member/signup/email/verify"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .logIn:
            return .post
        case .logOut:
            return .post
        case .signIn:
            return .post
        case .emailAuth:
            return .post
        case .emailAuthVerify:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .logIn(let email, let password):
            let body = AuthRequestEntity(email: email, password: password)
            return .requestJSONEncodable(body)
            
        case .logOut(let accessToken):
            let param = ["Authorization" : accessToken]
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
            
        case .signIn(let monthBudget, let name, let email, let password):
            let body = AuthRequestEntity(email: email, password: password, name: name, monthBudget: monthBudget)
            return .requestJSONEncodable(body)
            
        case .emailAuth(let email):
            let param = ["email" : email]
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
            
        case .emailAuthVerify(let email, let code):
            let param = ["email" : email, "code" : code]
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
        }
    }
}

fileprivate extension AuthAPI {
    struct AuthRequestEntity: Encodable {
        let email: String?
        let password: String?
        let name: String?
        let monthBudget: Int?
        
        init(
            email: String? = nil,
            password: String? = nil,
            name: String? = nil,
            monthBudget: Int? = nil
        ) {
            self.email = email
            self.password = password
            self.name = name
            self.monthBudget = monthBudget
        }
    }
}
