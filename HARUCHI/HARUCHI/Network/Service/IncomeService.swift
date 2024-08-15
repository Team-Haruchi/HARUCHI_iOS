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
    ) -> AnyPublisher<IncomeResponse<IncomeResult>, Error> {
        provider.requestPublisher(.income(incomeAmount: incomeAmount, category: category))
            .tryMap { response in
                guard (200...299).contains(response.statusCode) else {
                    throw URLError(.badServerResponse)
                }
                
                let incomeResponse = try JSONDecoder().decode(IncomeResponse<IncomeResult>.self, from: response.data)
                
                return incomeResponse
            }
            .eraseToAnyPublisher()
    }
    
    func deleteIncome(code: Int) -> AnyPublisher<IncomeResponse<IncomeResult>, Error> {
        provider.requestPublisher(.incomeDelete(code: code))
            .tryMap { response in
                guard (200...299).contains(response.statusCode) else {
                    throw URLError(.badServerResponse)
                }

                let incomeResponse = try JSONDecoder().decode(IncomeResponse<IncomeResult>.self, from: response.data)
                
                return incomeResponse
            }
            .eraseToAnyPublisher()
    }
}
