//
//  MostLikedPageModel.swift
//  AuthO
//
//  Created by Leoni Bernabe on 29/09/25.
//

import Foundation
import SwiftUI

struct MostLikedPageModel: Codable, Identifiable {
    var id = UUID()
    let title: String
    let likes: Int
    
    enum CodingKeys: String, CodingKey {
        case title = "reference_url"
        case likes = "count"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let rawTitle = try container.decode(String.self, forKey: .title)
        self.title = MostLikedPageModel.extractDomain(from: rawTitle)
        self.likes = try container.decode(Int.self, forKey: .likes)
    }
    
    init(title: String, likes: Int) {
        self.title = title
        self.likes = likes
    }
    
    private static func extractDomain(from urlString: String) -> String {
        guard let url = URL(string: urlString), let host = url.host else {
            return urlString
        }
        var domain = host
        if domain.hasPrefix("www.") {
            domain.removeFirst(4)
        }
        if let dotIndex = domain.firstIndex(of: ".") {
            domain = String(domain[..<dotIndex])
        }
        return domain
    }
}
