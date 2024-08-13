//
//  Base.swift
//  HARUCHI
//
//  Created by 이건우 on 8/13/24.
//

import Foundation

struct Base<T: Decodable>: Decodable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: T
}
