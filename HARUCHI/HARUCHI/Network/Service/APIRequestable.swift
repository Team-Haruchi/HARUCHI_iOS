//
//  APIRequestable.swift
//  HARUCHI
//
//  Created by 이건우 on 8/12/24.
//

import Foundation
import Combine
import Moya

protocol APIRequestable<APIType> {
    associatedtype APIType: TargetType
    
    /// Combine 맥락에서의 네트워크 요청
    func request<T: Decodable>(_ api: APIType, object: T.Type) -> AnyPublisher<T, MoyaError>
}
