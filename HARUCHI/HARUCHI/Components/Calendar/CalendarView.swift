import SwiftUI
import FSCalendar

// CustomCalendarCell 클래스는 FSCalendarCell을 상속하여 날짜 아래에 예산을 표시하는 UILabel을 추가
class CustomCalendarCell: FSCalendarCell {
    weak var budgetLabel: UILabel!
    var firstSelectionLayer: CAShapeLayer!
    var secondSelectionLayer: CAShapeLayer!
    var todayLayer: CAShapeLayer!

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 예산을 표시하는 UILabel을 생성하고 설정
        let budgetLabel = UILabel(frame: .zero)
        budgetLabel.textAlignment = .center
        budgetLabel.textColor = .black
        budgetLabel.font = UIFont(name: "Pretendard-Regular", size: 10)
        self.contentView.insertSubview(budgetLabel, at: 0)
        self.budgetLabel = budgetLabel
        
        // 첫 번째 선택된 날짜를 표시하는 레이어
        let firstSelectionLayer = CAShapeLayer()
        firstSelectionLayer.fillColor = UIColor.clear.cgColor
        self.contentView.layer.insertSublayer(firstSelectionLayer, below: self.titleLabel!.layer)
        self.firstSelectionLayer = firstSelectionLayer

        // 두 번째 선택된 날짜를 표시하는 레이어
        let secondSelectionLayer = CAShapeLayer()
        secondSelectionLayer.fillColor = UIColor.clear.cgColor
        self.contentView.layer.insertSublayer(secondSelectionLayer, below: self.titleLabel!.layer)
        self.secondSelectionLayer = secondSelectionLayer
        
        
        // 오늘 날짜를 표시하는 레이어
        let todayLayer = CAShapeLayer()
        todayLayer.fillColor = UIColor.clear.cgColor
        self.contentView.layer.insertSublayer(todayLayer, below: self.titleLabel!.layer)
        self.contentView.layer.insertSublayer(todayLayer, at: 0)
        self.todayLayer = todayLayer
    }

    required init!(coder aDecoder: NSCoder!) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 예산 라벨의 프레임을 설정 - 날짜 아래에 위치하도록
        self.budgetLabel.frame = CGRect(x: 0, y: self.contentView.bounds.height - 23, width: self.contentView.bounds.width, height: 20)
        
        // 예산 라벨을 최상위에 위치하도록 설정
        self.contentView.bringSubviewToFront(self.budgetLabel)
        
        // 선택된 날짜 레이어의 경로 설정 (크기 조절)
        let diameter: CGFloat = min(self.contentView.bounds.height, self.contentView.bounds.width) * 0.8 // 크기 조절
        let path = UIBezierPath(ovalIn: CGRect(x: (self.contentView.bounds.width - diameter) / 2, y: (self.contentView.bounds.height - 60), width: diameter, height: diameter))
        self.firstSelectionLayer.path = path.cgPath
        self.secondSelectionLayer.path = path.cgPath
        self.todayLayer.path = path.cgPath
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        // 셀 재사용 시 예산 텍스트를 초기화
        self.budgetLabel.text = nil
        self.firstSelectionLayer.fillColor = UIColor.clear.cgColor
        self.secondSelectionLayer.fillColor = UIColor.clear.cgColor
        self.todayLayer.fillColor = UIColor.clear.cgColor
    }
}


struct FSCalendarView: UIViewRepresentable {
    @ObservedObject var viewModel: CalendarViewModel
    
    
    func makeUIView(context: Context) -> FSCalendar {
        let calendar = FSCalendar()
        calendar.delegate = context.coordinator
        calendar.dataSource = context.coordinator
        
        // 사용자 지정 셀 등록
        calendar.register(CustomCalendarCell.self, forCellReuseIdentifier: "CustomCalendarCell")
        
        // 배경색 설정
        calendar.backgroundColor = UIColor(Color.sub3Blue)
        calendar.layer.cornerRadius = 8
        calendar.layer.masksToBounds = true

        // 헤더 텍스트 스타일 설정
        calendar.appearance.headerDateFormat = "yyyy년 M월"
        calendar.appearance.headerTitleColor = UIColor.black
        calendar.appearance.headerTitleFont = UIFont(name: "Pretendard-SemiBold", size: 12)
        calendar.headerHeight = 40 // 헤더 높이를 늘려서 마진 효과
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0 //헤더 좌,우측 흐릿한 글씨 삭제
        
        // 날짜 텍스트 스타일 설정
        calendar.appearance.titleDefaultColor = UIColor.black
        calendar.appearance.titleFont = UIFont(name: "Pretendard-SemiBold", size: 12)
        calendar.appearance.titleOffset = CGPoint(x: 0, y: -10) // 필요에 따라 오프셋 조정
        
        // 오늘 날짜(Today) 관련
        calendar.appearance.titleTodayColor = .black //Today에 표시되는 특정 글자색
        calendar.appearance.todayColor = .clear //Today에 표시되는 선택 전 동그라미 색
        
        calendar.appearance.selectionColor = .clear
        //calendar.appearance.titleSelectionColor = .black
        
        // 요일 숨기기
        calendar.weekdayHeight = 0 // 날짜 표시부 행의 높이
        
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
        var parent: FSCalendarView
        var viewModel: CalendarViewModel

        private var currentMonth: Date = Date() // 현재 월을 저장하는 변수

        init(_ parent: FSCalendarView, viewModel: CalendarViewModel) {
            self.parent = parent
            self.viewModel = viewModel
        }
        
        // 날짜 선택 시 호출되는 함수
        func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
            // 선택된 날짜를 UTC로 변환하여 날짜가 잘못 해석되지 않도록 처리
            let timeZoneOffset = TimeZone.current.secondsFromGMT(for: date)
            let correctedDate = Calendar.current.date(byAdding: .second, value: timeZoneOffset, to: date)!
            
            if viewModel.isDateInCurrentMonth(date, currentMonth: currentMonth){
                calendar.appearance.titleSelectionColor = .white
            } else {
                calendar.appearance.titleSelectionColor = UIColor(Color.gray5)
            }
            
            viewModel.selectDate(correctedDate)
            calendar.reloadData()
        }
        
        // 특정 날짜의 셀을 설정하는 함수
        func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
            let cell = calendar.dequeueReusableCell(withIdentifier: "CustomCalendarCell", for: date, at: position) as! CustomCalendarCell
            
            // 현재 월에 해당하는 날짜인지 확인하고, 예산을 설정합니다.
            if viewModel.isDateInCurrentMonth(date, currentMonth: currentMonth), let budget = viewModel.budget(for: date) {
                let formatter = NumberFormatter()
                formatter.numberStyle = .decimal
                cell.budgetLabel.text = formatter.string(from: NSNumber(value: budget))
            } else {
                cell.budgetLabel.text = ""
            }
            
            // 선택된 날짜의 색상 설정 및 텍스트 색상 설정
            if let firstDate = viewModel.firstSelectedDate, Calendar.current.isDate(date, inSameDayAs: firstDate) {
                cell.firstSelectionLayer.fillColor = UIColor(Color.mainBlue).cgColor
            } else if let secondDate = viewModel.secondSelectedDate, Calendar.current.isDate(date, inSameDayAs: secondDate) {
                cell.firstSelectionLayer.fillColor = UIColor(Color.mainBlue).cgColor
                cell.secondSelectionLayer.fillColor = UIColor(Color.haruchiRed).cgColor
            } else {
                cell.firstSelectionLayer.fillColor = UIColor.clear.cgColor
                cell.secondSelectionLayer.fillColor = UIColor.clear.cgColor
            }
            
            // 오늘 날짜의 색상 설정
            if Calendar.current.isDateInToday(date) {
                cell.todayLayer.fillColor = UIColor.white.cgColor
            } else {
                cell.todayLayer.fillColor = UIColor.clear.cgColor
            }
            
            return cell
        }

        // 특정 날짜의 제목을 설정하는 함수
        func calendar(_ calendar: FSCalendar, titleFor date: Date) -> String? {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "d"
            return dateFormatter.string(from: date)
        }
        
        // 선택된 날짜의 텍스트 색상을 설정하는 함수
        func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
            
            if let firstDate = viewModel.firstSelectedDate, Calendar.current.isDate(date, inSameDayAs: firstDate) {
                return .white
            } else if let secondDate = viewModel.secondSelectedDate, Calendar.current.isDate(date, inSameDayAs: secondDate) {
                return .white
            }
            if Calendar.current.isDate(date, equalTo: currentMonth, toGranularity: .month) {
                return .black
            } else {
                return UIColor(Color.gray5)
            }
        }
        
        // 현재 월을 업데이트하는 함수
        func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
            currentMonth = calendar.currentPage
            calendar.reloadData()
        }
    }
}

struct CalendarPreview: View {
    @StateObject private var viewModel = CalendarViewModel()
    @ObservedObject private var budgetViewModel = BudgetMainViewModel()
    
    var body: some View {
        VStack {
            FSCalendarView(viewModel: viewModel)
                .frame(width: 345, height: 380)
            VStack {
                let dates = viewModel.selectedDates()
                Text("첫 번째 선택한 날짜: \(viewModel.dateString(from: dates.0))")
                Text("두 번째 선택한 날짜: \(viewModel.dateString(from: dates.1))")
                Text("두 번째 선택한 날짜: \(viewModel.dateBudget)")
            }
        }
        
    }
}

#Preview {
    CalendarPreview()
}
