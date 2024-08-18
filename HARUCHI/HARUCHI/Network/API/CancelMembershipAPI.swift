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
    
    // HTTP 헤더에 하드코딩된 엑세스 토큰 추가
    public var headers: [String: String]? {
        return [
            "Content-type": "application/json",
            "Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJtZW1iZXJJZCI6MjIsImVtYWlsIjoidGVzdEB0ZXN0LmNvbSIsImlhdCI6MTcyNDAwMDQwMH0.lsP2x89gCkkGHhv_bYY6petkIUFaavaZSYRnqAToSL8"
        ]
    }
}
