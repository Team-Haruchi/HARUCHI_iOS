//
//  ExpenditureResult.swift
//  HARUCHI
//
//  Created by 채리원 on 8/18/24.
//

import Foundation


struct ExpenditureResult: Decodable {
    let expenditureCategory: Category?
    let expenditureAmount: Int?
    let createdAt: String
    let expenditureId: Int
}
