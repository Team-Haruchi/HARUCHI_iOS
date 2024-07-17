//
//  FontExtension.swift
//  HARUCHI
//
//  Created by 이건우 on 7/15/24.
//

import SwiftUI

extension Font {
    enum FontFamily: String {
        case Regular, Medium, SemiBold, Bold
        
        init?(weight: Int) {
            switch weight {
            case 400: self = .Regular
            case 500: self = .Medium
            case 600: self = .SemiBold
            case 700: self = .Bold
            default: return nil
            }
        }
    }
    
    enum HaruchiStyle {
        case h1, h2, h3
        case body_sb16, body_r16, body_m16, body_m14
        case button12, button14, button16
        case caption1, caption2, caption3
        
        var size: CGFloat {
            switch self {
            case .h1:
                return 24
            case .h2, .h3:
                return 20
            case .body_sb16, .body_r16, .body_m16, .button16:
                return 16
            case .body_m14, .button14:
                return 14
            case .button12, .caption1, .caption2:
                return 12
            case .caption3:
                return 10
            }
        }
            
        var family: FontFamily {
            switch self {
            case .h1:
                return .Bold
            case .h2, .body_sb16:
                return .SemiBold
            case .body_m14, .body_m16, .caption1:
                return .Medium
            case .h3, .body_r16, .button12, .button14, .button16, .caption2, .caption3:
                return .Regular
            }
        }
    }
    
    static func haruchi(_ style: HaruchiStyle) -> Font {
        return Font.custom("Pretendard-\(style.family.rawValue)", size: style.size)
    }
    
    static func haruchi(size: CGFloat, weight: Int) -> Font {
        guard let family = FontFamily(weight: weight) else {
            fatalError("Invalid weight value. Must be between 100 and 900.")
        }
        return Font.custom("Pretendard-\(family.rawValue)", size: size)
    }
     
    static func haruchi(size: CGFloat, family: FontFamily) -> Font {
        return Font.custom("Pretendard-\(family.rawValue)", size: size)
    }
}
