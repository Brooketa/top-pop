//
//  TracksData.swift
//  TopPop
//
//  Created by Brooketa on 14.05.2021..
//

import Foundation

struct TracksData: Codable {
    var tracks: [Track]
    
    enum CodingKeys: String, CodingKey {
        case tracks = "data"
    }
}
