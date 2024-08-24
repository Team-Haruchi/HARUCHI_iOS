//
//  CloseResponse.swift
//  HARUCHI
//
//  Created by 채리원 on 8/22/24.
//

import Foundation

struct Pull: Decodable {
    let redistributionOption: String
    let sourceDay: Int
    let targetDay: Int?
    let pullId: Int
    let createdAt: String
}

struct Push: Decodable {
    let redistributionOption: String
    let sourceDay: Int
    let targetDay: Int?
    let pushId: Int
    let createdAt: String
}

struct CloseResponse: Decodable {
    let dayBudget: Int
    let todayExpenditureAmount: Int
    let incomeList: [IncomeResult]
    let expenditureList: [ExpenditureResult]
    let pullList: [Pull]
    let pushList: [Push]
}

struct RedistributionResponse: Decodable {
    let redistributionOption: String

}
