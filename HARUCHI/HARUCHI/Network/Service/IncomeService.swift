//
//  IncomeService.swift
//  HARUCHI
//
//  Created by 채리원 on 8/15/24.
//

import Foundation
import Combine
import Moya
import CombineMoya

class IncomeService {
    private let provider = MoyaProvider<IncomeAPI>()
    
    func requestIncome(
        incomeAmount: Int,
        category: String
    ) -> AnyPublisher<Base<IncomeResult>, Error> {
        provider.requestPublisher(.income(incomeAmount: incomeAmount, category: category))
            .tryMap { response in
                guard (200...299).contains(response.statusCode) else {
                    print("[IncomeService] requestIncome() statusCode : ", response.statusCode)
                    throw MoyaError.statusCode(response)
                }
                return response.data
            }
            .decode(type: Base<IncomeResult>.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
