import SwiftUI
import FSCalendar
import UIKit

class CustomWeekCalendarCell: FSCalendarCell {
    weak var iconImageView: UIImageView!
    weak var budgetLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let imageView = UIImageView()
        self.contentView.addSubview(imageView)
        self.iconImageView = imageView
        
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        label.font = UIFont(name: "Pretendard-Regular", size: 10)
        self.contentView.addSubview(label)
        self.budgetLabel = label
        
        // Layout
        imageView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 35.5), //13.5일 때 거리 0
            imageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 22),
            imageView.heightAnchor.constraint(equalToConstant: 22),
            
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 12),
            label.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct WeekCalendarView: UIViewRepresentable {
    @ObservedObject var viewModel: WeekCalendarViewModel

    func makeUIView(context: Context) -> FSCalendar {
        let calendar = FSCalendar()
        calendar.delegate = context.coordinator
        calendar.dataSource = context.coordinator
        calendar.scope = .week
        
        // 커스텀 셀 등록
        calendar.register(CustomWeekCalendarCell.self, forCellReuseIdentifier: "customWeekCell")

        // 헤더 텍스트 스타일 설정
        calendar.appearance.headerTitleColor = .clear
        calendar.headerHeight = 28 //12 + 16
        calendar.appearance.headerMinimumDissolvedAlpha = 0 //헤더 좌,우측 흐릿한 글씨 삭제
        
        // 요일 텍스트 스타일 설정
        calendar.locale = Locale(identifier: "ko_US")
        calendar.firstWeekday = 2
        calendar.appearance.weekdayTextColor = .black
        calendar.weekdayHeight = 12
        
        
        // 날짜 텍스트 스타일 설정
        calendar.appearance.titleDefaultColor = UIColor.black
        calendar.appearance.titleFont = UIFont(name: "Pretendard-Regular", size: 12)
        calendar.appearance.titleOffset = CGPoint(x: 0, y: -23.5) // -33.5일 때 요일 텍스트와의 거리 0
        
        // 오늘 날짜(Today) 관련
        calendar.appearance.titleTodayColor = .black //Today에 표시되는 특정 글자색
        calendar.appearance.todayColor = .clear //Today에 표시되는 선택 전 동그라미 색
        
        // selection
        calendar.appearance.selectionColor = .clear
        calendar.appearance.titleSelectionColor = .black
        
        // WeekCalendarView 플래그 설정 (라이브러리 수정 부분)
        calendar.isWeekCalendarView = true

        // 커스텀 헤더 뷰 추가
        let headerView = UIView()
        
        let titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "Pretendard-Regular", size: 12)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(titleLabel)
        calendar.addSubview(headerView)
        
        // 레이아웃 설정
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: calendar.leadingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: headerView.topAnchor),
            
            headerView.topAnchor.constraint(equalTo: calendar.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: calendar.leadingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 12)
        ])
        
        // 초기 타이틀 설정
        titleLabel.text = viewModel.headerTitle
        
        context.coordinator.titleLabel = titleLabel
        context.coordinator.calendar = calendar
        
        return calendar
    }

    // updateUIView 메서드는 뷰모델의 데이터 변경에 따라 UI를 업데이트
    func updateUIView(_ uiView: FSCalendar, context: Context) {
        uiView.reloadData()
    }

    // makeCoordinator 메서드는 FSCalendar의 델리게이트와 데이터 소스를 관리하는 코디네이터를 생성
    func makeCoordinator() -> Coordinator {
        Coordinator(self, viewModel: viewModel)
    }

    // Coordinator 클래스는 FSCalendar의 델리게이트와 데이터 소스를 구현
    class Coordinator: NSObject, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
        var parent: WeekCalendarView
        var viewModel: WeekCalendarViewModel
        var titleLabel: UILabel?
        var calendar: FSCalendar?

        init(_ parent: WeekCalendarView, viewModel: WeekCalendarViewModel) {
            self.parent = parent
            self.viewModel = viewModel
        }
        
        // 해더 부분
        func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
            viewModel.currentPage = calendar.currentPage
            titleLabel?.text = viewModel.headerTitle
        }

//        func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
//            return 0 // 이벤트가 없으므로 0 반환
//        }
//
//        func calendar(_ calendar: FSCalendar, titleFor date: Date) -> String? {
//            return nil // 타이틀이 없으므로 nil 반환
//        }
        
        func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
            let cell = calendar.dequeueReusableCell(withIdentifier: "customWeekCell", for: date, at: position) as! CustomWeekCalendarCell
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            
            // 셀 초기화
            cell.iconImageView.image = nil
            cell.budgetLabel.text = nil
            
            // 주간 데이터에서 날짜에 해당하는 데이터를 찾기
            if let weekData = parent.viewModel.weekData.first(where: { formatter.string(from: $0.date) == formatter.string(from: date) }) {
                // 아이콘 설정
                if !weekData.icon.isEmpty {
                    cell.iconImageView.image = UIImage(named: weekData.icon)
                }
                
                // 예산 설정
                if let value = weekData.value {
                    let numberFormatter = NumberFormatter()
                    numberFormatter.numberStyle = .decimal
                    cell.budgetLabel.text = numberFormatter.string(from: NSNumber(value: value))
                } else {
                    cell.budgetLabel.text = ""
                }
            } else {
                // 기본 아이콘 설정
                cell.iconImageView.image = UIImage(named: "calendar_base")
                cell.budgetLabel.text = ""
            }
            return cell
        }
        
        // 오늘 날짜 이후로 선택 불가능
        func maximumDate(for calendar: FSCalendar) -> Date {
            return Date()
        }
        
        // 글자 색상을 항상 검정색으로 유지
        func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
            return .black
        }
    }
}

struct WeekCalendarPreview: View {
    @StateObject private var viewModel = WeekCalendarViewModel()
    
    var body: some View {
        VStack {
            WeekCalendarView(viewModel: viewModel)
                .frame(width: 338, height: 128)
        }
    }
}

#Preview {
    WeekCalendarPreview()
}
