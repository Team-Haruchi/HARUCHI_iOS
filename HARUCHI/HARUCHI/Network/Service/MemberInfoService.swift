//
//  MemberInfoService.swift
//  HARUCHI
//
//  Created by 이슬기 on 8/18/24.
//

import Foundation
import Combine
import Moya
import CombineMoya

class MemberInfoService {
    private let provider = MoyaProvider<MemberInfoAPI>()
    
    func fetchMemberInfo() -> AnyPublisher<Base<MemberInfoResponse>, Error> {
        provider.requestPublisher(.getMemberInfo)
            .tryMap { response in
                guard (200...299).contains(response.statusCode) else {
                    print("[MemberInfoService] fetchMemberInfo() statusCode : ", response.statusCode)
                    throw MoyaError.statusCode(response)
                }
                return response.data
            }
            .decode(type: Base<MemberInfoResponse>.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
