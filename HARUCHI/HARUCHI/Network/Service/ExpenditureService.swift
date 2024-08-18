//
//  ExpenditureService.swift
//  HARUCHI
//
//  Created by 채리원 on 8/18/24.
//

import Foundation
import Combine
import Moya
import CombineMoya

class ExpenditureService {
    private var provider = MoyaProvider<ExpenditureAPI>()
    
    init(token: String) {
        self.provider = MoyaProvider<ExpenditureAPI>(plugins:[AuthPlugin(token: token)])
    }
    
    func requestExpenditure(
        ExpenditureAmount: Int,
        category: String
    ) -> AnyPublisher<Base<ExpenditureResult>, Error> {
        return provider.requestPublisher(.expenditure(expenditureAmount: expenditureAmount, category: category))
            .tryMap { response in
                guard (200...299).contains(response.statusCode) else {
                    print("[ExpenditureService] requestExpenditure() statusCode: \(resonse.statusCode)")
                    throw MoyaError.statusCode(response)
                }
                return response.data
            }
            .decode(type: Base<IncomeResult>.self, decoder: JSONDecoder())
            .receive(on: DisqatchQueue.main)
            .eraseToAnyPublisher()
    }
}
