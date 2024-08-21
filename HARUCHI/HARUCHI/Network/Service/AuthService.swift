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

// TODO: - 각 상황별로 더 자세한 에러처리 필요
enum EmailAuthError: Error {
    
}

class AuthService {
    private let provider = MoyaProvider<AuthAPI>()
    
    // 로그인 요청
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
    
    // 이메일 인증 코드 요청
    func requestEmailAuthCode(for email: String) -> AnyPublisher<BaseWithOutResult, Error>{
        provider.requestPublisher(.emailAuth(email: email))
            .tryMap { response in
                guard (200...299).contains(response.statusCode) else {
                    print("[AuthService] requestEmailAuthCode() statusCode : ", response.statusCode)
                    throw MoyaError.statusCode(response)
                }
                return response.data
            }
            .decode(type: BaseWithOutResult.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    // 이메일 인증 코드 검증 요청
    func verifyEmailAuthCode(
        email: String,
        code: String
    ) -> AnyPublisher<BaseWithOutResult, Error> {
        provider.requestPublisher(.emailAuthVerify(email: email, code: code))
            .tryMap { response in
                guard (200...299).contains(response.statusCode) else {
                    print("[AuthService] verifyEmailAuthCode() statusCode : ", response.statusCode)
                    throw MoyaError.statusCode(response)
                }
                return response.data
            }
            .decode(type: BaseWithOutResult.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    // 회원가입 요청
    func requestSignIn(
        email: String,
        password: String,
        monthBudget: Int,
        name: String
    ) -> AnyPublisher<BaseWithOutResult, Error> {
        provider.requestPublisher(.signIn(monthBudget: monthBudget, name: name, email: email, password: password))
            .tryMap { response in
                guard (200...299).contains(response.statusCode) else {
                    print("[AuthService] requestSignIn() statusCode : ", response.statusCode)
                    throw MoyaError.statusCode(response)
                }
                return response.data
            }
            .decode(type: BaseWithOutResult.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
