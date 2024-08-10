import SwiftUI
import FSCalendar
import UIKit

struct WeekCalendarModel {
    var date: Date
    var icon: String
    var value: Int?
}


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
    @ObservedObject var viewModel: HomeViewModel
    
    // currentPage와 headerTitle을 관리하는 상태 프로퍼티들
    @State private var currentPage: Date = Date()
    @State private var headerTitle: String = ""

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
        context.coordinator.titleLabel = titleLabel
        context.coordinator.calendar = calendar
        
        DispatchQueue.main.async {
            updateHeaderTitle()
            titleLabel.text = headerTitle
        }
        
        return calendar
    }
    
    func updateHeaderTitle() {
        var calendar = Calendar.current
        calendar.firstWeekday = 2 // 한 주의 첫 날을 월요일로 설정

        let weekOfMonth = calendar.component(.weekOfMonth, from: currentPage)
        let month = calendar.component(.month, from: currentPage)
        headerTitle = "\(month)월 \(weekOfMonth)째주"
    }

    func updateUIView(_ uiView: FSCalendar, context: Context) {
        uiView.reloadData()
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self, viewModel: viewModel)
    }

    class Coordinator: NSObject, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
        var parent: WeekCalendarView
        var viewModel: HomeViewModel
        var titleLabel: UILabel?
        var calendar: FSCalendar?

        init(_ parent: WeekCalendarView, viewModel: HomeViewModel) {
            self.parent = parent
            self.viewModel = viewModel
        }
        
        func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
            parent.currentPage = calendar.currentPage
            parent.updateHeaderTitle()
            titleLabel?.text = parent.headerTitle
        }
        
        func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
            let cell = calendar.dequeueReusableCell(withIdentifier: "customWeekCell", for: date, at: position) as! CustomWeekCalendarCell
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            
            cell.iconImageView.image = nil
            cell.budgetLabel.text = nil
            
            if let weekData = parent.viewModel.weekData.first(where: { formatter.string(from: $0.date) == formatter.string(from: date) }) {
                if !weekData.icon.isEmpty {
                    cell.iconImageView.image = UIImage(named: weekData.icon)
                }
                
                if let value = weekData.value {
                    let numberFormatter = NumberFormatter()
                    numberFormatter.numberStyle = .decimal
                    cell.budgetLabel.text = numberFormatter.string(from: NSNumber(value: value))
                } else {
                    cell.budgetLabel.text = ""
                }
            } else {
                cell.iconImageView.image = UIImage(named: "calendar_base")
                cell.budgetLabel.text = ""
            }
            return cell
        }
        
        func maximumDate(for calendar: FSCalendar) -> Date {
            return Date()
        }
        
        func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
            return .black
        }
    }
}

struct WeekCalendarPreview: View {
    @StateObject private var viewModel = HomeViewModel()
    
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
