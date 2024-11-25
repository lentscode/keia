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
       @StateObject private var viewModelStatsIntent = CreatePurchaseIntentViewModel(questions:[])
       
       //Segmented bar control as colors
       init(){
           UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor : UIColor.prime], for: .selected)
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
            .toolbar{
                //Media punteggio
                ToolbarItem(placement: .navigationBarLeading){
                    Menu {
                        Button(action: { selectedOption = "Score" }) {
                            Label("Score",systemImage: selectedOption == "Score" ? "checkmark" : "")
                        }
                        Button(action: { selectedOption = "Media" }) {
                            Label("Expense",systemImage: selectedOption == "Expense" ? "checkmark" : "")
                        }
                        Button(action: { selectedOption = "Media" }) {
                            Label("Savings",systemImage: selectedOption == "Savings" ? "checkmark" : "")
                        }
                    } label: {
                        Image(systemName: "line.horizontal.3")
                            .font(.body)
                            .foregroundColor(.black)
                    }
                }
            }
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button(action: { isSheetOpen = true }) {
                        Image(systemName:"plus.circle.fill")
                            .font(.body)
                            .foregroundColor(.prime)
                    
                    }
                }
            }
        }
        .sheet(isPresented: $isSheetOpen){
            CreationProcessView().environmentObject(viewModelStatsIntent)
        }
    }
}

#Preview {
    StatsView()
}
