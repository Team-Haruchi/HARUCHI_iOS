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
    
    func requestIncome(
        incomeAmount: Int,
        category: String
    ) -> AnyPublisher<Base<CloseResult>, Error> {
        return provider.requestPublisher(.close(redistributionOption: redistributionOption, year: year, month: month, day: day))
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
}
