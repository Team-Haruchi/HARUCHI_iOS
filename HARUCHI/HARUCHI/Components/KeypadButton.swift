//
//  keypadButton.swift
//  HARUCHI
//
//  Created by 채리원 on 7/21/24.
//

import SwiftUI

struct KeypadButton: View {
    private var text: String
    private var enable: Bool
    private var action: () -> Void
    
    init(
        text: String = "",
        enable: Bool = true,
        action: @escaping () -> Void
    ) {
        self.text = text
        self.enable = enable
        self.action = action
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Button(action: action) {
                Text(text)
                    .font(.haruchi(.button14))
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width, height: 45)
                    .background(enable ? Color.mainBlue : Color.sub2Blue)
            }
            .disabled(!enable)
        }
    }
}

struct KeypadButton_Previews: PreviewProvider {
    static var previews: some View {
        KeypadButton(text: "확인", enable: true, action: {
            print("버튼 눌림 ㅇㅇ")
        })
    }
}
