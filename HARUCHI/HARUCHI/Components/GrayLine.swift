//
//  GrayLine.swift
//  HARUCHI
//
//  Created by 이건우 on 7/21/24.
//

import SwiftUI

struct GrayLine: View {
    var body: some View {
        Rectangle()
            .frame(maxWidth: .infinity)
            .frame(height: 1)
            .foregroundColor(Color.gray3)
    }
}

#Preview {
    GrayLine()
}
