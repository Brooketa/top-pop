//
//  Track.swift
//  TopPop
//
//  Created by Brooketa on 14.05.2021..
//

import Foundation

struct Track: Codable {
    var title: String
    var duration: Int
    var position: Int?
    var album: Album?
    var artist: Artist?
}
