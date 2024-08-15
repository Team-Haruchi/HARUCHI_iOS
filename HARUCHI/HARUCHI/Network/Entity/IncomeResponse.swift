//
//  IncomeResponse.swift
//  HARUCHI
//
//  Created by 채리원 on 8/15/24.
//

import Foundation

struct IncomeResponse<T: Decodable>: Decodable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: T
}

struct IncomeResult: Decodable {
    let createdAt: String
    let incomeID: Int
}
