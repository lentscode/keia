//
//  TabBar.swift
//  keia
//
//  Created by Francesco Romeo on 28/11/24.
//

import SwiftUI

struct InsightsTabBar: View {
    @EnvironmentObject private var vm: InsightsViewModel
    
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(0...vm.categories.count, id: \.self) { n in
                    if n == 0 {
                        TabElement(category: "All", value: .null)
                    } else {
                        TabElement(category: vm.categories[n - 1])
                    }
                }
            }
        }
    }
}

fileprivate struct TabElement: View {
    @EnvironmentObject private var vm: InsightsViewModel
    private let category: String
    private let value: String?
    
    init(category: String, value: TabValue = .category) {
        self.category = category
        
        if value == .category {
            self.value = category
        } else {
            self.value = nil
        }
    }
    
    var body: some View {
        VStack {
            Text(category)
                .font(.system(size: 20))
                .fontWeight(vm.categoryFocused == value ? .semibold: .regular)
                .foregroundColor(vm.categoryFocused == value ? .black : .gray)
                .padding(.bottom, 5)
                .padding(.horizontal, 5)
            
            Rectangle()
                .fill(vm.categoryFocused == value ? Color.black : Color.clear)
                .frame(height: 2)
        }
        .frame(maxWidth: .infinity)
        .onTapGesture {
            vm.categoryFocused = value
        }
    }
}

fileprivate enum TabValue {
    case null, category
}

#Preview {
    InsightsTabBar()
        .environmentObject(InsightsViewModel(insightsService: InsightsService()))
        .padding(.horizontal)
}
