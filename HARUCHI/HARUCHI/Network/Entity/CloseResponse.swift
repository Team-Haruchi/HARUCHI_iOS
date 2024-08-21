//
//  CloseResponse.swift
//  HARUCHI
//
//  Created by 채리원 on 8/22/24.
//

import Foundation

struct CloseResponse: Decodable {
    let dayBudget: Int
    let todayExpenditureAmount: Int
    let incomeList: [IncomeResult]
    let expenditureList: [ExpenditureResult]
    let pullList: [String] 
    let pushList: [String]
}

struct RedistributionResponse: Decodable {
    let redistributionOption: String

}
