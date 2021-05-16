//
//  AlbumDetailsViewController.swift
//  TopPop
//
//  Created by Brooketa on 17.05.2021..
//

import UIKit
import SDWebImage

class AlbumDetailsViewController: UIViewController {
    
    @IBOutlet weak var albumCoverImageView: UIImageView!
    @IBOutlet weak var albumTitleLabel: UILabel!
    @IBOutlet weak var trackTitleLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var trackListLabel: UILabel!
    
    static let identifier = "AlbumDetailsViewController"
    
    var albumCoverImageURL: String!
    var album: Album!
    var track: Track!
    var albumTracks: [Track]!

    override func viewDidLoad() {
        super.viewDidLoad()
        loadAlbumInfo()
    }
    
    private func loadAlbumInfo() {
        guard let albumCoverImageURL = albumCoverImageURL else { return }
        albumCoverImageView.sd_setImage(with: URL(string: albumCoverImageURL), placeholderImage: nil, options: SDWebImageOptions.highPriority, completed: nil)
        
        if let album = album {
            albumTitleLabel.text = "Album title: " + album.title
        }
        
        if let track = track {
            trackTitleLabel.text = "Track title: " + track.title
        }
        
        if let artist = track.artist {
            artistNameLabel.text = "Artist name: " + artist.name
        }
        
        var trackListString: String = "Track List: \n\n"
        var number: Int = 1
        for track in albumTracks {
            trackListString += "\(number). \(track.title)\n"
            number += 1
        }
        trackListLabel.text = trackListString
    }
}
