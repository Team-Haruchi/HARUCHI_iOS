import SwiftUI
import Combine

class MemberInfoViewModel: ObservableObject {
    @Published var memberInfoCreatedAt: String = "none"
    @Published var memberInfoEmail: String = "none"
    @Published var memberInfoName: String = "none"
    
    private var cancellables = Set<AnyCancellable>()
    private let service = MemberInfoService()
    
    func fetchMemberInfo() {
        service.fetchMemberInfo()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Network request failed: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] baseResponse in
                self?.memberInfoCreatedAt = baseResponse.result.createdAt
                self?.memberInfoEmail = baseResponse.result.email
                self?.memberInfoName = baseResponse.result.name
            })
            .store(in: &cancellables)
    }
}
