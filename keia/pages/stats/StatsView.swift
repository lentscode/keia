//
//  StatsView.swift
//  keia
//
//  Created by Antonio Lentini on 20/11/24.
//

import SwiftUI

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
                    
                    PurchaseIntentsCharts(type: svm.type, report: svm.report)
                        .frame(height: 200)
                        .padding(.horizontal, 16)                 
                }
            }
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
    }
}

#Preview {
    StatsView()
        .setEnvironment()
}
