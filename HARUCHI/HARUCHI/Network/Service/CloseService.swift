//
//  CloseService.swift
//  HARUCHI
//
//  Created by 채리원 on 8/20/24.
//

import Foundation
import Combine
import Moya
import CombineMoya

class CloseService {
    private var provider = MoyaProvider<CloseAPI>()
    
    init(token: String) {
        self.provider = MoyaProvider<CloseAPI>(plugins: [AuthPlugin(token: token)])
    }
    
    func closeBudget(
        redistributionOption: String,
        year: Int,
        month: Int,
        day: Int
    ) -> AnyPublisher<Base<CloseResult>, Error> {
        return provider.requestPublisher(.closeBudget(redistributionOption: redistributionOption, year: year, month: month, day: day))
            .tryMap { response in
                guard (200...299).contains(response.statusCode) else {
                    print("[CloseService] requestIncome() statusCode: \(response.statusCode)")
                    throw MoyaError.statusCode(response)
                }
                return response.data
            }
            .decode(type: Base<CloseResult>.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func closeCheck (
        year: Int,
        month: Int,
        day: Int
    ) -> AnyPublisher<Base<CloseResult>, Error> {
        return provider.requestPublisher(.closeCheck(year: year, month: month, day: day))
            .tryMap { response in
                guard (200...299).contains(response.statusCode) else {
                    print("[CloseService] closeCheck() statusCode: \(response.statusCode)")
                    throw MoyaError.statusCode(response)
                }
                return response.data
            }
            .decode(type: Base<CloseResult>.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func closeCheckLast() -> AnyPublisher<Base<CloseResult>, Error> {
        return provider.requestPublisher(.closeCheckLast)
            .tryMap { response in
                guard (200...299).contains(response.statusCode) else {
                    print("[CloseService] closeCheckLast() statusCode: \(response.statusCode)")
                    throw MoyaError.statusCode(response)
                }
                return response.data
            }
            .decode(type: Base<CloseResult>.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func closeAmount(
        year: Int,
        month: Int,
        day: Int
    ) -> AnyPublisher<Base<CloseResult>, Error> {
        return provider.requestPublisher(.closeAmount(year: year, month: month, day: day))
            .tryMap { response in
                guard (200...299).contains(response.statusCode) else {
                    print("[CloseService] closeAmount() statusCode: \(response.statusCode)")
                    throw MoyaError.statusCode(response)
                }
                return response.data
            }
            .decode(type: Base<CloseResult>.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
