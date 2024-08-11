//
//  LoginViewModel.swift
//  HARUCHI
//
//  Created by 이건우 on 8/11/24.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var email: String
    @Published var password: String
    
    init(
        email: String = "",
        password: String = ""
    ) {
        self.email = email
        self.password = password
    }
    
    // 이메일과 비밀번호를 모두 입력했는지 체크
    func checkInput() -> Bool {
        return (email != "" && password != "")
    }
}
