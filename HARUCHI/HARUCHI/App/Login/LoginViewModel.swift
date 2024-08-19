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
    
    @Published var isLoading: Bool = false
    @Published var showErrorAlert: Bool = false
    @Published var showSignInView: Bool = false
    
    private let appState: AppState
    private let authService = AuthService()
    private var cancellables = Set<AnyCancellable>()
    
    init(
        appState: AppState,
        email: String = "",
        password: String = ""
    ) {
        self.appState = appState
        self.email = email
        self.password = password
    }
    
    func checkInput() -> Bool {
        return (email != "" && password != "")
    }
    
    func login() {
        isLoading = true
        
        authService.requestLogin(email: email, password: password)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.handleError(error)
                    self.loginFail()
                }
            } receiveValue: { response in
                print(response.result.accessToken)
                self.loginProcess(with: response.result.accessToken)
            }
            .store(in: &cancellables)
    }
    
    private func loginFail() {
        showErrorAlert = true
        isLoading = false
    }
    
    // Saving accessToken at Keychain & Change AppState
    private func loginProcess(with token: String) {
        KeychainManager.save(token: token, for: .accessToken)
        appState.isLoggedIn = true
        isLoading = false
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
