//
//  CancelMembershipAPI.swift
//  HARUCHI
//
//  Created by 이슬기 on 8/19/24.
//

import Foundation
import Moya

enum CancelMembershipAPI {
    case cancelMembership(reason: String)
}

extension CancelMembershipAPI: BaseAPI {
    // 요청 경로
    var path: String {
        switch self {
        case .cancelMembership:
            return "/member/delete"
        }
    }
    
    // HTTP 요청 메소드
    var method: Moya.Method {
        switch self {
        case .cancelMembership:
            return .post
        }
    }
    
    // HTTP 작업 유형
    var task: Moya.Task {
        switch self {
        case .cancelMembership(let reason):
            return .requestParameters(parameters: ["reason": reason], encoding: URLEncoding.queryString)
        }
    }
    
    // HTTP 헤더에 저장된 엑세스 토큰 추가
    var headers: [String: String]? {
        var headers = ["Content-type": "application/json"]
        
        // 키체인에서 토큰을 가져와 Authorization 헤더에 추가
        if let token = KeychainManager.load(for: .accessToken) {
            headers["Authorization"] = "Bearer \(token)"
        } else {
            print("키체인에서 토큰을 찾을 수 없습니다.")
        }
        
        return headers
    }
}
