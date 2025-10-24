//
//  CategoryModel.swift
//  AuthO
//
//  Created by Leoni Bernabe on 24/09/25.
//

import Foundation
import SwiftUI

struct CategoryModel: Codable, Equatable, Identifiable {
    let id: Int
    let name: String
    let icon: String
    let description: String
    
    var categoryColor: Color {
        if let category = CategoryColor(rawValue: id) {
            return category.color
        }
        
        return Color.gray // default color
    }
}

enum CategoryColor: Int, CaseIterable {
    case one = 1
    case two
    case three
    case four
    case five
    case six
    case seven
    case eight
    case nine
    case ten
    case eleven
    case twelve
    case thirteen
    case fourteen
    case fifteen
    case sixteen
    case seventeen
    case eighteen
    case nineteen
    case twenty

    var color: Color {
        switch self {
        case .one: return .red
        case .two: return .blue
        case .three: return .green
        case .four: return .orange
        case .five: return .purple
        case .six: return .mint
        case .seven: return .pink
        case .eight: return .yellow
        case .nine: return .teal
        case .ten: return .indigo
        case .eleven: return .brown
        case .twelve: return .cyan
        case .thirteen: return .gray
        case .fourteen: return .black
        case .fifteen: return .white
        case .sixteen: return Color(red: 0.9, green: 0.4, blue: 0.6)   // custom color
        case .seventeen: return Color(red: 0.3, green: 0.6, blue: 0.9) // custom color
        case .eighteen: return Color(red: 0.8, green: 0.7, blue: 0.2)  // custom color
        case .nineteen: return Color(red: 0.5, green: 0.3, blue: 0.7)  // custom color
        case .twenty: return Color(red: 0.2, green: 0.8, blue: 0.4)   // custom color
        }
    }
}
