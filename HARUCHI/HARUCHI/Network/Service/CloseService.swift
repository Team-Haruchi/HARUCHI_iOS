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
    
    init() {
        self.provider = MoyaProvider<CloseAPI>(plugins: [AuthPlugin()])
    }
    
    func closeReceipt(
        year: Int,
        month: Int,
        day: Int
    ) -> AnyPublisher<Base<CloseResponse>, Error> {
        return provider.requestPublisher(.closeReceipt(year: year, month: month, day: day))
            .tryMap { response in
                guard (200...299).contains(response.statusCode) else {
                    print("[IncomeService] requestIncome() statusCode: \(response.statusCode)")
                    throw MoyaError.statusCode(response)
                }
                return response.data
            }
            .decode(type: Base<CloseResponse>.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func closeBudget(
        redistributionOption: String,
        year: Int,
        month: Int,
        day: Int
    ) -> AnyPublisher<Base<RedistributionResponse>, Error> {
        return provider.requestPublisher(.closeBudget(redistributionOption: redistributionOption, year: year, month: month, day: day))
            .tryMap { response in
                guard (200...299).contains(response.statusCode) else {
                    print("[CloseService] closeBudget() statusCode: \(response.statusCode)")
                    throw MoyaError.statusCode(response)
                }
                return response.data
            }
            .decode(type: Base<RedistributionResponse>.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func closeAmount(
        year: Int,
        month: Int,
        day: Int
    ) -> AnyPublisher<Base<CloseResponse>, Error> {
        return provider.requestPublisher(.closeAmount(year: year, month: month, day: day))
            .tryMap { response in
                guard (200...299).contains(response.statusCode) else {
                    print("[CloseService] closeAmount() statusCode: \(response.statusCode)")
                    throw MoyaError.statusCode(response)
                }
                return response.data
            }
            .decode(type: Base<CloseResponse>.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
