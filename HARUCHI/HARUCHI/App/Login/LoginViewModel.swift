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
    private var cancellables = Set<AnyCancellable>()
    private let authService = AuthService()
    
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
                    self.logInFail()
                }
            } receiveValue: { response in
                print(response.result.accessToken)
                
                // MARK: - TODO
                // save accessToken with Keychain
                // other process... ex) AppState
                
                self.logInSuccess()
            }
            .store(in: &cancellables)
    }
    
    private func logInFail() {
        showErrorAlert = true
        isLoading = false
    }
    
    private func logInSuccess() {
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
