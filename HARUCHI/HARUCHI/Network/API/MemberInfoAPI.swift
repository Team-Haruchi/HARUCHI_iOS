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
    
//    // HTTP 헤더에 하드코딩된 엑세스 토큰 추가
//    public var headers: [String: String]? {
//        return [
//            "Content-type": "application/json",
//            "Authorization": "Bearer accessToken"
//        ]
//    }
}
