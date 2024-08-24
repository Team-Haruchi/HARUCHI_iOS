//
//  BaseWithOutResult.swift
//  HARUCHI
//
//  Created by 이슬기 on 8/19/24.
//

import Foundation

struct BaseWithOutResult: Decodable {
    let isSuccess: Bool
    let code: String
    let message: String
}
