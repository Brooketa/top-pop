//
//  ChartTableViewCell.swift
//  TopPop
//
//  Created by Brooketa on 16.05.2021..
//

import UIKit
import SDWebImage

class ChartTableViewCell: UITableViewCell {
    
    @IBOutlet weak var artistImageView: UIImageView!
    @IBOutlet weak var trackTitleLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    static let cellIdentifier = "ChartTableViewCell"
    
    public func configure(with track:Track) {
        guard let artist = track.artist else { return }
        guard let artistImageURL = artist.imageURL else { return }
        guard let position = track.position else { return }
        
        artistImageView.sd_setImage(with: URL(string: artistImageURL), placeholderImage: nil, options: SDWebImageOptions.highPriority, completed: nil)
        artistImageView.roundCorners(withCornerRadius: 3.0)
        trackTitleLabel.text = "\(position). " + track.title
        artistNameLabel.text = artist.name
        durationLabel.text = "Duration: " + String().secondsToMinutesSeconds(seconds: track.duration)
        activityIndicator.isHidden = true
    }
}
