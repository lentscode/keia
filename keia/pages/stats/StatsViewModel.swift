//
//  StatsViewModel.swift
//  keia
//
//  Created by Francesco Romeo on 25/11/24.
//

import Foundation

enum ChooseReport: String, CaseIterable{
    case weekly = "Weekly"
    case monthly = "Monthly"
    case annual = "Annual"
}

class StatsViewModel: ObservableObject{
    @Published var report: ChooseReport = .weekly
    @Published var type: ChartType = .score
}

