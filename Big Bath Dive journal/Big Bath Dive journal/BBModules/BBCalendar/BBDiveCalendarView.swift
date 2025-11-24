//
//  BBDiveCalendarView.swift
//  Big Bath Dive journal
//
//

import SwiftUI

struct BBDiveCalendarView: View {
    @ObservedObject var viewModel: BBMyDivesViewModel
    
    @State private var displayedMonth: Date = Date()
    
    private let calendar = Calendar.current
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text("Calendar")
                        .font(.system(size: 24, weight: .semibold))
                    
                    Spacer()
                }.padding(.horizontal, 20)
                
                
                VStack(alignment: .leading, spacing: 20) {
                    
                    VStack(spacing: 10) {
                        monthHeader
                        weekdayHeader
                        monthGrid
                            .frame(height: 200)
                    }
                    .padding(.horizontal, 12).padding(.vertical, 16)
                    .background(Color(hex: "005399"))
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    
                    Rectangle()
                        .fill(Color(hex: "005399") ?? .blue)
                        .frame(height: 1)
                        .frame(maxWidth: .infinity)
                    
                    divesList
                    
                    
                }.padding(.horizontal, 20).padding(.top, 8)
                    .background(Color(hex: "DFF1FB"))
                    .ignoresSafeArea(edges: .bottom)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            
        }.background(Color(hex: "EBF8FF").ignoresSafeArea())
        
    }
    
    private var divesList: some View {
        let monthDives = divesForDisplayedMonth()
        
        return Group {
            if monthDives.isEmpty {
                Text("No dives this month")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            } else {
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 8) {
                        ForEach(monthDives) { dive in
                            NavigationLink {
                                BBDiveDetailsView(dive: dive)
                                    .navigationBarBackButtonHidden()
                            } label: {
                                BBDiveCell(dive: dive)
                            }
                            
                        }
                    }
                }
            }
        }
    }
    
    // Заголовок: месяц, год, стрелки
    private var monthHeader: some View {
        HStack(spacing: 15) {
            Text(monthTitle(for: displayedMonth))
                .font(.system(size: 20, weight: .medium))
            
            Spacer()
            Button {
                changeMonth(by: -1)
            } label: {
                Image(systemName: "chevron.left")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 15)
                    .bold()
            }
            
            Button {
                changeMonth(by: 1)
            } label: {
                Image(systemName: "chevron.right")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 15)
                    .bold()
            }
        }.foregroundStyle(.white)
    }
    
    // Заголовок дней недели
    private var weekdayHeader: some View {
        let symbols = calendar.shortStandaloneWeekdaySymbols // Пн, Вт, ...
        
        return HStack {
            ForEach(0..<7, id: \.self) { index in
                Text(symbols[safe: (index + calendar.firstWeekday - 1) % 7] ?? "")
                    .font(.system(size: 15, weight: .medium))
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.white)
            }
        }
    }
    
    // Сетка дней месяца
    private var monthGrid: some View {
        let columns = Array(repeating: GridItem(.flexible(), spacing: 4), count: 7)
        
        return LazyVGrid(columns: columns, spacing: 10) {
            ForEach(daysForMonth(), id: \.self) { date in
                if let date {
                    dayCell(for: date)
                } else {
                    // Пустая ячейка перед началом месяца
                    Color.clear
                        .frame(height: 40)
                }
            }
        }
    }
    
    private func divesForDisplayedMonth() -> [DiveModel] {
        viewModel.myDives
            .filter { dive in
                calendar.isDate(dive.date, equalTo: displayedMonth, toGranularity: .month)
            }
            .sorted { $0.date < $1.date }
    }
    
    // Одна ячейка дня
    private func dayCell(for date: Date) -> some View {
        let day = calendar.component(.day, from: date)
        let mood = moodForDate(date)
        
        return VStack(spacing: 4) {
            
            // Маркер дайва
            if let mood {
                Circle()
                    .fill(mood.color)
                    .frame(width: 8, height: 8)
            } else {
                Circle()
                    .fill(Color.clear)
                    .frame(width: 8, height: 8)
            }
            
            Text("\(day)")
                .font(.body)
                .foregroundStyle(.white)
            
            
        }
        .frame(maxWidth: .infinity)
        .frame(height: 25)
    }
    
    // MARK: - Логика
    
    private func changeMonth(by value: Int) {
        if let newDate = calendar.date(byAdding: .month, value: value, to: displayedMonth) {
            displayedMonth = newDate
        }
    }
    
    private func monthTitle(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.calendar = calendar
        formatter.dateFormat = "LLLL yyyy"  // например, "Январь 2025"
        return formatter.string(from: date).capitalized
    }
    
    /// Строим массив дат для текущего месяца с учётом пустых ячеек в начале
    private func daysForMonth() -> [Date?] {
        guard
            let monthInterval = calendar.dateInterval(of: .month, for: displayedMonth),
            let firstDay = calendar.date(from: calendar.dateComponents([.year, .month], from: monthInterval.start))
        else {
            return []
        }
        
        let range = calendar.range(of: .day, in: .month, for: firstDay) ?? 1..<2
        let numberOfDays = range.count
        
        // Смещение от начала недели (учитываем firstWeekday)
        let firstWeekdayOfMonth = calendar.component(.weekday, from: firstDay)
        let weekdayOffset = (firstWeekdayOfMonth - calendar.firstWeekday + 7) % 7
        
        var days: [Date?] = Array(repeating: nil, count: weekdayOffset)
        
        for day in 0..<numberOfDays {
            if let date = calendar.date(byAdding: .day, value: day, to: firstDay) {
                days.append(date)
            }
        }
        
        return days
    }
    
    /// Находим mood для конкретной даты (если есть хоть один дайв)
    private func moodForDate(_ date: Date) -> Mood? {
        let dive = viewModel.myDives.first { dive in
            calendar.isDate(dive.date, inSameDayAs: date)
        }
        return dive?.mood
    }
}

// MARK: - Безопасный доступ к массиву (чтобы не вылетало с weekdaySymbols)

private extension Array {
    subscript(safe index: Int) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}

#Preview {
    BBDiveCalendarView(viewModel: BBMyDivesViewModel())
}
