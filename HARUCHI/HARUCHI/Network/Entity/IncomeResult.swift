//
//  IncomeResult.swift
//  HARUCHI
//
//  Created by 채리원 on 8/16/24.
//

import Foundation


struct IncomeResult: Decodable {
    let incomeCategory: Category?
    let incomeAmount: Int?
    let createdAt: String
    let incomeId: Int
}
