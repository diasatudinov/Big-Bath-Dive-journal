//
//  DiveMoodStatsView.swift
//  Big Bath Dive journal
//
//  Created by Dias Atudinov on 24.11.2025.
//


import SwiftUI

// MARK: - Вью статистики настроения

struct DiveMoodStatsView: View {
    @ObservedObject var viewModel: BBMyDivesViewModel

    @State private var displayedMonth: Date = Date()
    private let calendar = Calendar.current
    
    private let monthFormatter: DateFormatter = {
        let f = DateFormatter()
        f.calendar = Calendar.current
        f.dateFormat = "LLLL yyyy" // Январь 2025
        return f
    }()
    
    var body: some View {
        
        ZStack {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text("Monthly Statistics")
                        .font(.system(size: 24, weight: .semibold))
                    
                    Spacer()
                }.padding(.horizontal, 20)
                
                
                ScrollView(showsIndicators: false) {
                    
                    VStack(alignment: .leading, spacing: 20) {
                        
                        VStack(spacing: 24) {
                            monthHeader
                            
                            if currentMonthDives.isEmpty {
                                Text("No dives this month")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                            } else {
                                donutChart
                            }
                        }.padding(.vertical, 16)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                        
                        Rectangle()
                            .fill(Color(hex: "005399") ?? .blue)
                            .frame(height: 1)
                            .frame(maxWidth: .infinity)
                        
                        HStack {
                            VStack {
                                Text("Depth")
                                    .font(.system(size: 24, weight: .semibold))
                                    .foregroundStyle(Color(hex: "FDE402") ?? .yellow)
                                
                                Text("\(viewModel.showAvgDepth(monthDives: currentMonthDives)) m")
                                    .font(.system(size: 20, weight: .medium))
                                    .foregroundStyle(Color(hex: "FDE402") ?? .yellow)
                            }
                            .padding(.vertical, 21)
                            .frame(width: (UIScreen.main.bounds.width - 76)/2)
                            .background(Color(hex: "005399"))
                            .clipShape(RoundedRectangle(cornerRadius: 22))
                            
                            Spacer()
                            
                            VStack {
                                Text("Duration")
                                    .font(.system(size: 24, weight: .semibold))
                                    .foregroundStyle(Color(hex: "FDE402") ?? .yellow)
                                
                                Text("\(viewModel.showAvgDuration(monthDives: currentMonthDives)) min")
                                    .font(.system(size: 20, weight: .medium))
                                    .foregroundStyle(Color(hex: "FDE402") ?? .yellow)
                            }
                            .padding(.vertical, 21)
                            .frame(width: (UIScreen.main.bounds.width - 76)/2)
                            .background(Color(hex: "005399"))
                            .clipShape(RoundedRectangle(cornerRadius: 22))
                            
                            
                        }
                        
                        Rectangle()
                            .fill(Color(hex: "005399") ?? .blue)
                            .frame(height: 1)
                            .frame(maxWidth: .infinity)
                        
                        
                        VStack {
                            ForEach(viewModel.showTop10Wildlife(monthDives: currentMonthDives), id: \.wildlife) { wildlife in
                                
                                
                                HStack(alignment: .center) {
                                    
                                    if let image = wildlife.wildlife.image {
                                        Image(uiImage: image)
                                            .resizable()
                                            .scaledToFit()
                                            .padding(-16)
                                    } else {
                                        Image(systemName: "photo.fill")
                                            .resizable()
                                            .scaledToFit()
                                            .padding(-16)
                                    }
                                    
                                    VStack(alignment: .leading ,spacing: 2) {
                                        HStack {
                                            Text(wildlife.wildlife.name)
                                                .font(.system(size: 15, weight: .semibold))
                                                .foregroundStyle(Color(hex: "FDE402") ?? .yellow)
                                            Spacer()
                                            
                                            Text("\(wildlife.count)")
                                                .font(.system(size: 15, weight: .semibold))
                                                .foregroundStyle(Color(hex: "FDE402") ?? .yellow)
                                        }
                                        
                                    }.padding(.leading)
                                    
                                    
                                }
                                .padding()
                                .frame(height: 70)
                                .background(Color(hex: "005399"))
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                
                                
                            }
                        }
                        
                        
                    }.padding(.horizontal, 20).padding(.top, 8)
                        .background(Color(hex: "DFF1FB"))
                        .ignoresSafeArea(edges: .bottom)
                        .padding(.bottom, 130)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            
        }.background(Color(hex: "EBF8FF").ignoresSafeArea())

    }
    
    // MARK: - Заголовок месяца
    
    private var monthHeader: some View {
        
        HStack(spacing: 15) {
            Text(monthFormatter.string(from: displayedMonth).capitalized)
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
        }.foregroundStyle(.black)
            
    }
    
    // MARK: - Донат (бублик) диаграмма
    
    private var donutChart: some View {
        let segments = moodSegments(for: currentMonthDives)
        let totalCount = currentMonthDives.count
        let topSegment = segments.first
        
        return ZStack {
            // Сегменты бублика
            ForEach(segments) { segment in
                DonutSegment(startAngle: segment.startAngle,
                             endAngle: segment.endAngle)
                    .fill(segment.mood.color)
            }
            .frame(width: 330, height: 330)
            
            // Центр с основной эмоцией
            if let top = topSegment {
                VStack(spacing: 4) {
                    Image(top.mood.rawValue)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 50)
                    
                    Text("\(top.mood.name)")
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundColor(.black)
                    
                    Text("\(Int(round(top.percentage * 100)))%")
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundColor(top.mood.color)
                    
                }
            }
        }
    }
    
    
    // MARK: - Логика
    
    private var currentMonthDives: [DiveModel] {
        viewModel.myDives
            .filter { dive in
                calendar.isDate(dive.date, equalTo: displayedMonth, toGranularity: .month)
            }
    }
    
    private func changeMonth(by value: Int) {
        if let newDate = calendar.date(byAdding: .month, value: value, to: displayedMonth) {
            displayedMonth = newDate
        }
    }
    
    // Формируем сегменты бублика
    private func moodSegments(for dives: [DiveModel]) -> [MoodSegment] {
        guard !dives.isEmpty else { return [] }
        
        let counts: [Mood: Int] = dives.reduce(into: [:]) { result, dive in
            result[dive.mood, default: 0] += 1
        }
        
        let total = dives.count
        var startAngleDegrees: Double = -90 // старт сверху
        
        // сортируем по убыванию встречаемости
        let sorted = counts.sorted { $0.value > $1.value }
        
        var segments: [MoodSegment] = []
        
        for (mood, count) in sorted {
            let percentage = Double(count) / Double(total)
            let degrees = percentage * 360
            let segment = MoodSegment(
                mood: mood,
                count: count,
                percentage: percentage,
                startAngle: .degrees(startAngleDegrees),
                endAngle: .degrees(startAngleDegrees + degrees)
            )
            segments.append(segment)
            startAngleDegrees += degrees
        }
        
        return segments
    }
}

// MARK: - Модель сегмента

private struct MoodSegment: Identifiable {
    let id = UUID()
    let mood: Mood
    let count: Int
    let percentage: Double
    let startAngle: Angle
    let endAngle: Angle
}

// MARK: - Shape для бублика

struct DonutSegment: Shape {
    var startAngle: Angle
    var endAngle: Angle
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        let innerRadius = radius * 0.75
        
        path.addArc(
            center: center,
            radius: radius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: false
        )
        
        path.addArc(
            center: center,
            radius: innerRadius,
            startAngle: endAngle,
            endAngle: startAngle,
            clockwise: true
        )
        
        path.closeSubpath()
        return path
    }
}



#Preview {
    DiveMoodStatsView(viewModel: BBMyDivesViewModel())
}

struct MonthlyWildlifeTop: Identifiable {
    let id: String          // "2025-01"
    let year: Int
    let month: Int          // 1...12
    let dateForTitle: Date  // 1 число месяца, удобно для форматирования
    let items: [(wildlife: Wildlife, count: Int)]
}

private struct MonthKey: Hashable {
    let year: Int
    let month: Int
}

extension Array where Element == DiveModel {
    func monthlyTop10Wildlife(
        calendar: Calendar = .current
    ) -> [MonthlyWildlifeTop] {
        // Группируем дайвы по (year, month)
        let grouped = Dictionary(grouping: self) { dive -> MonthKey in
            let comps = calendar.dateComponents([.year, .month], from: dive.date)
            return MonthKey(
                year: comps.year ?? 0,
                month: comps.month ?? 0
            )
        }
        
        var result: [MonthlyWildlifeTop] = []
        
        for (key, divesInMonth) in grouped {
            guard key.year != 0, key.month != 0 else { continue }
            
            // Считаем частоты wildlife внутри месяца
            var counts: [Wildlife: Int] = [:]
            for dive in divesInMonth {
                for item in dive.wildlife {
                    counts[item, default: 0] += 1
                }
            }
            
            // Сортируем по убыванию количества
            let sorted = counts.sorted { lhs, rhs in
                lhs.value > rhs.value
            }
            
            // Берём максимум 10
            let top10 = sorted.prefix(10).map { (wildlife: $0.key, count: $0.value) }
            
            // Дата для заголовка (1 число месяца)
            var comps = DateComponents()
            comps.year = key.year
            comps.month = key.month
            comps.day = 1
            let date = calendar.date(from: comps) ?? Date()
            
            let id = String(format: "%04d-%02d", key.year, key.month)
            
            result.append(
                MonthlyWildlifeTop(
                    id: id,
                    year: key.year,
                    month: key.month,
                    dateForTitle: date,
                    items: top10
                )
            )
        }
        
        // Сортируем месяцы по дате
        return result.sorted { $0.dateForTitle < $1.dateForTitle }
    }
}
