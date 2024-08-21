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
    private let provider = MoyaProvider<BudgetAPI>(plugins: [AuthPlugin()])
    
    func fetchBudget() -> AnyPublisher<Base<BudgetResponse>, Error> {
        provider.requestPublisher(.dailyBudgetCheck)
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
    
    func fetchSafeBox() -> AnyPublisher<Base<SafeBoxResponse>, Error> {
        provider.requestPublisher(.safeBoxCheck)
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
    
    func fetchDateBudget() -> AnyPublisher<Base<DateBudgetResponse>, Error> {
        provider.requestPublisher(.dateBudgetCheck)
            .tryMap { response in
                guard (200...299).contains(response.statusCode) else {
                    print("[BudgetService] fetchDateBudget statusCode : ", response.statusCode)
                    throw MoyaError.statusCode(response)
                }
//                print("Raw JSON Data: \(String(data: response.data, encoding: .utf8) ?? "No Data")")
                return response.data
            }
            .decode(type: Base<DateBudgetResponse>.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func fetchMonthBudget() -> AnyPublisher<Base<MonthBudgetResponse>, Error> {
        provider.requestPublisher(.monthlyBudgetCheck)
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
    
    func fetchLeftNow() -> AnyPublisher<Base<LeftNowResponse>, Error> {
        provider.requestPublisher(.leftNowCheck)
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
    
    func fetchBudgetPercent() -> AnyPublisher<Base<BudgetPercentResponse>, Error> {
        provider.requestPublisher(.budgetPercentCheck)
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
    
    func fetchWeekBudget() -> AnyPublisher<Base<WeekBudgetResponse>, Error> {
        provider.requestPublisher(.weekBudgetCheck)
            .tryMap { response in
                guard (200...299).contains(response.statusCode) else {
                    print("[BudgetService] fetchWeekBudget statusCode : ", response.statusCode)
                    throw MoyaError.statusCode(response)
                }
//                print("Raw JSON Data: \(String(data: response.data, encoding: .utf8) ?? "No Data")")
                return response.data
            }
            .decode(type: Base<WeekBudgetResponse>.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func requestEditBudget(
        monthBudget : Int
    ) -> AnyPublisher<Base<EditBudgetResponse>, Error> {
        provider.requestPublisher(.monthlyBudgetEdit(monthBudget: monthBudget))
            .tryMap { response in
                guard (200...299).contains(response.statusCode) else {
                    print("[BudgetService] requestEditBudget() statusCode : ", response.statusCode)
                    throw MoyaError.statusCode(response)
                }
//                print("Raw JSON Data: \(String(data: response.data, encoding: .utf8) ?? "No Data")")
                return response.data

            }
            .decode(type: Base<EditBudgetResponse>.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func requestPushBudget(
        redistributionOption : String,
        amount : Int,
        sourceDay : Int,
        targetDay : Int?

    ) -> AnyPublisher<Base<PushRedistributionResponse>, Error> {
        provider.requestPublisher(.pushBudget(redistributionOption: redistributionOption, amount: amount, sourceDay: sourceDay, targetDay: targetDay))
            .tryMap { response in
                guard (200...299).contains(response.statusCode) else {
                    print("[BudgetService] requestEditBudget() statusCode : ", response.statusCode)
                    throw MoyaError.statusCode(response)
                }
                print("Raw JSON Data: \(String(data: response.data, encoding: .utf8) ?? "No Data")")
                return response.data

            }
            .decode(type: Base<PushRedistributionResponse>.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
}
