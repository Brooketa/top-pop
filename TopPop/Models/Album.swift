//
//  Album.swift
//  TopPop
//
//  Created by Brooketa on 14.05.2021..
//

import Foundation

struct Album: Codable {
    var id: Int
    var title: String
    var coverImageURL: String
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case coverImageURL = "cover"
    }
}
