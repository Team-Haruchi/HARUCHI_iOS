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
//                print("Raw JSON Data: \(String(data: response.data, encoding: .utf8) ?? "No Data")")
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
//                print("Raw JSON Data: \(String(data: response.data, encoding: .utf8) ?? "No Data")")
                return response.data
            }
            .decode(type: Base<SafeBoxResponse>.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func fetchDateBudget (
        accessToken: String
    ) -> AnyPublisher<Base<DateBudgetResponse>, Error> {
        provider.requestPublisher(.dateBudgetCheck(accessToken: accessToken))
            .tryMap { response in
                guard (200...299).contains(response.statusCode) else {
                    print("[BudgetService] fetchDateBudget statusCode : ", response.statusCode)
                    throw MoyaError.statusCode(response)
                }
                print("Raw JSON Data: \(String(data: response.data, encoding: .utf8) ?? "No Data")")
                return response.data
            }
            .decode(type: Base<DateBudgetResponse>.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func fetchMonthBudget (
        accessToken: String
    ) -> AnyPublisher<Base<MonthBudgetResponse>, Error> {
        provider.requestPublisher(.monthlyBudgetCheck(accessToken: accessToken))
            .tryMap { response in
                guard (200...299).contains(response.statusCode) else {
                    print("[BudgetService] fetchMonthBudget statusCode : ", response.statusCode)
                    throw MoyaError.statusCode(response)
                }
//                print("Raw JSON Data: \(String(data: response.data, encoding: .utf8) ?? "No Data")")
                return response.data
            }
            .decode(type: Base<MonthBudgetResponse>.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func fetchLeftNow (
        accessToken: String
    ) -> AnyPublisher<Base<LeftNowResponse>, Error> {
        provider.requestPublisher(.leftNowCheck(accessToken: accessToken))
            .tryMap { response in
                guard (200...299).contains(response.statusCode) else {
                    print("[BudgetService] fetchLeftNow statusCode : ", response.statusCode)
                    throw MoyaError.statusCode(response)
                }
//                print("Raw JSON Data: \(String(data: response.data, encoding: .utf8) ?? "No Data")")
                return response.data
            }
            .decode(type: Base<LeftNowResponse>.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func fetchBudgetPercent (
        accessToken: String
    ) -> AnyPublisher<Base<BudgetPercentResponse>, Error> {
        provider.requestPublisher(.budgetPercentCheck(accessToken: accessToken))
            .tryMap { response in
                guard (200...299).contains(response.statusCode) else {
                    print("[BudgetService] fetchBudgetPercent statusCode : ", response.statusCode)
                    throw MoyaError.statusCode(response)
                }
//                print("Raw JSON Data: \(String(data: response.data, encoding: .utf8) ?? "No Data")")
                return response.data
            }
            .decode(type: Base<BudgetPercentResponse>.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func fetchWeekBudget (
        accessToken: String
    ) -> AnyPublisher<Base<WeekBudgetResponse>, Error> {
        provider.requestPublisher(.weekBudgetCheck(accessToken: accessToken))
            .tryMap { response in
                guard (200...299).contains(response.statusCode) else {
                    print("[BudgetService] fetchWeekBudget statusCode : ", response.statusCode)
                    throw MoyaError.statusCode(response)
                }
                print("Raw JSON Data: \(String(data: response.data, encoding: .utf8) ?? "No Data")")
                return response.data
            }
            .decode(type: Base<WeekBudgetResponse>.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
}
