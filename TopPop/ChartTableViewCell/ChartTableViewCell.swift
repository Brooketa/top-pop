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
    
    static let cellIdentifier = "ChartTableViewCell"
    
    public func configure(with track:Track) {
        guard let artist = track.artist else { return }
        guard let artistImageURL = artist.imageURL else { return }
        guard let position = track.position else { return }
        
        artistImageView.sd_setImage(with: URL(string: artistImageURL), placeholderImage: nil, options: SDWebImageOptions.highPriority, completed: nil)
        trackTitleLabel.text = "\(position). " + track.title
        artistNameLabel.text = artist.name
        durationLabel.text = "Duration: " + String().secondsToMinutesSeconds(seconds: track.duration)
        configureArtistImageBorder()
    }
    
    private func configureArtistImageBorder() {
        self.artistImageView.layer.cornerRadius = 3.0
        self.artistImageView.layer.borderWidth = 1.0
        self.artistImageView.layer.borderColor = UIColor.clear.cgColor
        self.artistImageView.layer.masksToBounds = true
    }
}
