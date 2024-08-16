//
//  BudgetService.swift
//  HARUCHI
//
//  Created by 이상엽 on 8/14/24.
//

import Foundation
import Combine

import Moya
import CombineMoya

class BudgetService {
    private let provider = MoyaProvider<BudgetAPI>()
    
    func fetchBudget (
        accessToken: String
    ) -> AnyPublisher<Base<BudgetResponse>, Error> {
        provider.requestPublisher(.dailyBudgetCheck(accessToken: accessToken))
            .tryMap { response in
                guard (200...299).contains(response.statusCode) else {
                    print("[BudgetService] fetchBudget() statusCode : ", response.statusCode)
                    throw MoyaError.statusCode(response)
                }
                print("Raw JSON Data: \(String(data: response.data, encoding: .utf8) ?? "No Data")")
                return response.data
            }
            .decode(type: Base<BudgetResponse>.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func fetchSafeBox (
        accessToken: String
    ) -> AnyPublisher<Base<SafeBoxResponse>, Error> {
        provider.requestPublisher(.safeBoxCheck(accessToken: accessToken))
            .tryMap { response in
                guard (200...299).contains(response.statusCode) else {
                    print("[BudgetService] fetchSafeBox() statusCode : ", response.statusCode)
                    throw MoyaError.statusCode(response)
                }
                print("Raw JSON Data: \(String(data: response.data, encoding: .utf8) ?? "No Data")")
                return response.data
            }
            .decode(type: Base<SafeBoxResponse>.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
}
