//
//  FontExtension.swift
//  HARUCHI
//
//  Created by 이건우 on 7/15/24.
//

import SwiftUI

extension Font {
    enum Family: String {
        // 100 to 900 in ascending order
        case Thin, ExtraLight, Light, Regular, Medium, SemiBold, Bold, ExtraBold, Black
        
        init?(weight: Int) {
            switch weight {
            case 100: self = .Thin
            case 200: self = .ExtraLight
            case 300: self = .Light
            case 400: self = .Regular
            case 500: self = .Medium
            case 600: self = .SemiBold
            case 700: self = .Bold
            case 800: self = .ExtraBold
            case 900: self = .Black
            default: return nil
            }
        }
    }
    
    static func haruchi(size: CGFloat, weight: Int) -> Font {
        guard let family = Family(weight: weight) else {
            fatalError("Invalid weight value. Must be between 100 and 900.")
        }
        return Font.custom("Pretendard-\(family.rawValue)", size: size)
    }
    
    static func haruchi(size: CGFloat, family: Family) -> Font {
        return Font.custom("Pretendard-\(family.rawValue)", size: size)
    }
}
