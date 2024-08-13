//
//  AuthService.swift
//  HARUCHI
//
//  Created by 이건우 on 8/12/24.
//

import Foundation
import Combine

import Moya
import CombineMoya	

class AuthService {
    private let provider = MoyaProvider<AuthAPI>()
    
    func requestLogin(
        email : String,
        password: String
    ) -> AnyPublisher<Base<LoginResponse>, Error> {
        provider.requestPublisher(.logIn(email: email, password: password))
            .tryMap { response in
                guard (200...299).contains(response.statusCode) else {
                    print("[AuthService] requestLogin() statusCode : ", response.statusCode)
                    throw MoyaError.statusCode(response)
                }
                return response.data
            }
            .decode(type: Base<LoginResponse>.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
