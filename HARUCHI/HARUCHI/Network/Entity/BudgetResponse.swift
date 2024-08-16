//
//  BudgetResponse.swift
//  HARUCHI
//
//  Created by 이상엽 on 8/14/24.
//

import Foundation

struct BudgetResponse: Decodable {
    let dayBudget: Int
}

struct SafeBoxResponse: Decodable {
    let safeBox: Int
}

struct DateBudgetResponse: Decodable {
    let budget: Int
}


