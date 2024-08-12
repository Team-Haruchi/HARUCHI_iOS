//
//  LoadingView.swift
//  HARUCHI
//
//  Created by 이건우 on 8/13/24.
//

import SwiftUI

struct LoadingView: View {
    @State var alignTo: Alignment = .center
    var body: some View {
        ProgressView()
            .frame(maxWidth: UIScreen.main.bounds.width, alignment: alignTo)
            .frame(maxHeight: UIScreen.main.bounds.height, alignment: alignTo)
        
    }
}
