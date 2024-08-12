//
//  LoginViewModel.swift
//  HARUCHI
//
//  Created by 이건우 on 8/11/24.
//

import Foundation
import Combine

import Moya

final class LoginViewModel: ObservableObject {
    @Published var email: String
    @Published var password: String
    
    @Published var showSignInView: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    private let authService = AuthService()
    
    init(
        email: String = "",
        password: String = ""
    ) {
        self.email = email
        self.password = password
    }
    
    func checkInput() -> Bool {
        return (email != "" && password != "")
    }
    
    func login() {
        authService.requestLogin(email: email, password: password)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.handleError(error)
                }
            } receiveValue: { response in
                print(response.result.accessToken)
                
                // MARK: - TODO
                // save accessToken with Keychain
                // other process... ex) AppState
            }
            .store(in: &cancellables)
    }
    
    private func handleError(_ error: Error) {
        if let moyaError = error as? MoyaError {
            switch moyaError {
            case .statusCode(let response):
                print("Login Failed with status code: \(response.statusCode)")
            default:
                print(moyaError.localizedDescription)
            }
        } else {
            print("Cannot casting to MoyaError")
        }
    }
}
