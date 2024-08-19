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

// TODO: - 각 상황별로 더 자세한 에러처리 필요 (서버측에서 정리 안된 듯)
enum EmailAuthError: Error {
    
}

class AuthService {
    private let provider = MoyaProvider<AuthAPI>()
    
    // 로그인은 발생할 수 있는 에러가 한 가지이기 때문에 따로 에러처리를 세분화 하지 않음
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
    
    func requestEmailAuthCode(for email: String) -> AnyPublisher<TestA, Error>{
        provider.requestPublisher(.emailAuth(email: email))
            .tryMap { response in
                guard (200...299).contains(response.statusCode) else {
                    print("[AuthService] requestEmailAuthCode() statusCode : ", response.statusCode)
                    throw MoyaError.statusCode(response)
                }
                return response.data
            }
            .decode(type: TestA.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}


struct TestA: Decodable {
    let isSuccess: Bool
    let code: String
    let message: String
}
