//
//  StatsView.swift
//  keia
//
//  Created by Antonio Lentini on 20/11/24.
//

import SwiftUI
import SwiftData

struct StatsView: View {
    @EnvironmentObject private var pvm: CreatePurchaseIntentViewModel
    @EnvironmentObject private var svm: StatsViewModel
    
    init() {
        UISegmentedControl.appearance().setTitleTextAttributes(
            [.foregroundColor: UIColor.prime],
            for: .selected
        )
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Picker("Report", selection: $svm.report) {
                        ForEach(ChooseReport.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    
                    StatsBodyView(
                        report: svm.report,
                        type: svm.type,
                        predicate: svm.predicate()
                    )
                }
            }
            .navigationTitle("Stats")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        pvm.isCreationProcessPresented = true
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.body)
                            .foregroundColor(.prime)
                        
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Menu {
                        Picker("Type", selection: $svm.type) {
                            ForEach(ChartType.allCases, id: \.self) {
                                Text($0.rawValue)
                            }
                        }
                        .pickerStyle(.inline)
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .foregroundColor(.black)
                    }
                }
            }
        }
        .purchaseSheet(
            isCreationProcessPresented: $pvm.isCreationProcessPresented,
            isPurchaseScorePresented: $pvm.isPurchaseScorePresented,
            purchase: pvm.purchase
        )
        .onAppear {
        }
    }
}

fileprivate struct StatsBodyView: View {
    @Query private var purchases: [PurchaseIntent]
    private var report: ChooseReport
    private var type: ChartType
    
    init(report: ChooseReport, type: ChartType, predicate: Predicate<PurchaseIntent>) {
        self.report = report
        self.type = type
        
        _purchases = Query(
            filter: predicate,
            sort: \.createdAt
        )
    }
    
    var body: some View {
        PurchaseIntentsCharts(purchases: purchases, type: type, report: report)
            .frame(height: 200)
            .padding(.horizontal, 16)
            .padding(.vertical, 20)
        
        GeneralStatsView(purchases: purchases, report: report, type: type)
    }
}

#Preview {
    StatsView()
        .setEnvironment()
}
