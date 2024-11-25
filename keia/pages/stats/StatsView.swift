//
//  StatsView.swift
//  keia
//
//  Created by Antonio Lentini on 20/11/24.
//

import SwiftUI

struct StatsView: View {

    //Variable to select which report want to see
    @State private var selectionReport: ChooseReport = .weekly

    @State private var selectedOption = "Score"

    @State private var isSheetOpen = false

    //StateObject: this view is responsible for creating the object and will keep it in memory for its entire duration.
    @StateObject private var viewModelStatsIntent =
        CreatePurchaseIntentViewModel(questions: [])

    @EnvironmentObject private var svm: StatsViewModel

    //Segmented bar control as colors
    init() {
        UISegmentedControl.appearance().setTitleTextAttributes(
            [.foregroundColor: UIColor.prime], for: .selected)
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Picker("Choose a report", selection: $selectionReport) {
                        ForEach(ChooseReport.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { isSheetOpen = true }) {
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
        .sheet(isPresented: $isSheetOpen) {
            CreationProcessView().environmentObject(viewModelStatsIntent)
        }
    }
}

#Preview {
    StatsView()
        .environmentObject(StatsViewModel())
}
