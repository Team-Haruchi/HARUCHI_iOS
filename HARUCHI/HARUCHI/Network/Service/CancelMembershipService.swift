//
//  CancelMembershipService.swift
//  HARUCHI
//
//  Created by 이슬기 on 8/19/24.
//

import Foundation
import Combine
import Moya
import CombineMoya

class CancelMembershipService {
    private let provider = MoyaProvider<CancelMembershipAPI>()
    
    func cancelMembership(reason: String) -> AnyPublisher<CancelMembershipResponse, Error> {
        provider.requestPublisher(.cancelMembership(reason: reason))
            .tryMap { response in
                guard (200...299).contains(response.statusCode) else {
                    print("[AuthService] requestLogin() statusCode : ", response.statusCode)
                    throw MoyaError.statusCode(response)
                }
                return response.data
            }
            .decode(type: CancelMembershipResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

