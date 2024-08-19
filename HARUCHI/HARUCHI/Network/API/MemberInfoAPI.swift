//
//  MemberInfoAPI.swift
//  HARUCHI
//
//  Created by 이슬기 on 8/17/24.
//

import Foundation
import Moya

enum MemberInfoAPI {
    case getMemberInfo
}

extension MemberInfoAPI: BaseAPI {
    // 요청 경로
    var path: String {
        switch self {
        case .getMemberInfo:
            return "/member/"
        }
    }
    
    // HTTP 요청 메소드
    var method: Moya.Method {
        switch self {
        case .getMemberInfo:
            return .get
        }
    }
    
    // HTTP 작업 유형
    var task: Moya.Task {
        switch self {
        case .getMemberInfo:
            return .requestPlain
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
