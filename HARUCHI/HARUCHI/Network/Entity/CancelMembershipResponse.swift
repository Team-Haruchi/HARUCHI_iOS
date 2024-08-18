//
//  CancelMembershipResponse.swift
//  HARUCHI
//
//  Created by 이슬기 on 8/19/24.
//

import Foundation

struct CancelMembershipResponse: Decodable {
    let isSuccess: Bool
    let code: String
    let message: String
}
