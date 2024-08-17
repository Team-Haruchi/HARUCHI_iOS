//
//  MemberInfoBase.swift
//  HARUCHI
//
//  Created by 이슬기 on 8/17/24.
//

import Foundation

struct MemberInfoResponse: Decodable {
    let createdAt: String
    let email: String
    let name: String
}
