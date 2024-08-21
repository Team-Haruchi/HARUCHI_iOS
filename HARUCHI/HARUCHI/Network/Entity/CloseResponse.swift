//
//  CloseResponse.swift
//  HARUCHI
//
//  Created by 채리원 on 8/22/24.
//

import Foundation

struct CloseResponse: Decodable {
    let year: Int
    let month: Int
    let day: Int
}

struct RedistributionResponse: Decodable {
    let redistributionOption: String

}
