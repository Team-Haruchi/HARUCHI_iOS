//
//  HomeViewModel.swift
//  HARUCHI
//
//  Created by 채리원 on 7/31/24.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var money = ""
    @Published var selectedCategory = "미분류"
    @Published var upSpendSheet = false
    @Published var showMainButton = false
    @Published var selectedType = ""
    @Published var selectedIncome = "미분류"
    @Published var showIncomeSheet = false
    
    
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
