import Foundation

// 날짜별 예산 데이터
struct CalendarModel: Identifiable {
    let id = UUID()    // 각 객체를 고유하게 식별하기 위한 UUID
    let date: Date     // 예산이 적용되는 날짜
    let budget: Double // 해당 날짜의 예산 금액
}
