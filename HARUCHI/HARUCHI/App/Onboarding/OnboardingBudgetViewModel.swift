//
//  OnboardingBudgetViewModel.swift
//  HARUCHI
//
//  Created by 채리원 on 7/23/24.
//

import SwiftUI
import Combine

class OnboardingBudgetViewModel: ObservableObject {
    @Published var text = ""
    @Published var tag: Int? = nil
}
