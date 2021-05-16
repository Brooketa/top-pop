//
//  StringExtensions.swift
//  TopPop
//
//  Created by Brooketa on 16.05.2021..
//

import Foundation

extension String {
    func secondsToMinutesSeconds(seconds: Int) -> String {
        let minutes = (seconds % 3600) / 60
        let seconds = (seconds % 3600) % 60
        return seconds < 10 ? "\(minutes):0\(seconds)" : "\(minutes):\(seconds)"
    }
}
