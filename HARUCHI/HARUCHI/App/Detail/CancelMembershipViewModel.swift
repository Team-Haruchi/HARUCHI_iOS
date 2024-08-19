//
//  CancelMembershipViewModel.swift
//  HARUCHI
//
//  Created by 이슬기 on 8/19/24.
//

import SwiftUI
import Combine

class CancelMembershipViewModel: ObservableObject {
    @Published var message: String = "" // 탈퇴 이유
    @Published var isChecked: Bool = false // 동의 체크 여부
    @Published var isCanceled: Bool = false // 로그인 화면으로 이동 여부를 추적하는 프로퍼티 추가

    private let service = CancelMembershipService()
    private var cancellables = Set<AnyCancellable>()

    // 회원탈퇴를 요청하는 메서드
    func cancelMembership() {
        guard !message.isEmpty && isChecked else {
            print("모든 조건을 만족해야 탈퇴가 가능합니다.")
            return
        }

        service.cancelMembership(reason: message)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Membership cancellation completed.")
                    //self.isCanceled = true // 성공 시 네비게이션 트리거
                case .failure(let error):
                    print("Failed to cancel membership with error: \(error)")
                }
            }, receiveValue: { response in
                print("Server response: \(response)")
            })
            .store(in: &cancellables)
    }
}
