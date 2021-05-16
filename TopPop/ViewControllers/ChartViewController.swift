//
//  ViewController.swift
//  TopPop
//
//  Created by Brooketa on 14.05.2021..
//

import UIKit

class ChartViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var tracks = [Track]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let menuButton = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(showMenu))
        menuButton.tintColor = .systemGray
        navigationItem.rightBarButtonItem = menuButton
        
        //Table View Configuration
        tableView.delegate = self
        tableView.dataSource = self
        tableView.refreshControl = UIRefreshControl(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        tableView.refreshControl?.tintColor = .systemGray
        tableView.refreshControl?.addTarget(self, action: #selector(getTracks), for: UIControl.Event.valueChanged)
        
        getTracks()
    }
    
    @objc private func getTracks() {
        WebService.fetchTracks(completion: { [weak self] response, error in
            let isRefreshing = self?.tableView.refreshControl?.isRefreshing
            if error == nil {
                if response != nil {
                    guard let tracks = response?.tracksData.tracks else { return }
                    self?.tracks = tracks
                    UIView.animate(withDuration: 0.3, animations: {
                        if isRefreshing != nil {
                            self?.tableView.refreshControl?.endRefreshing()
                        }
                        self?.tableView.reloadData()
                    })
                }
            } else {
                if isRefreshing != nil {
                    self?.tableView.refreshControl?.endRefreshing()
                    print("Error message: \(error as Any)")
                }
            }
        })
    }
    
    private func showAlbumInfo(album: Album, for track: Track, cell: ChartTableViewCell) {
        WebService.fetchAlbum(albumID: "\(album.id)", completion: { [weak self] response, error in
            if error == nil {
                if response != nil {
                    guard let tracks = response?.tracksData.tracks else { return }
                                        
                    let storyboard = UIStoryboard(name: "AlbumDetails", bundle: nil)
                    
                    guard let albumDetailsViewController = storyboard.instantiateViewController(identifier: AlbumDetailsViewController.identifier) as? AlbumDetailsViewController else { return }
                    
                    albumDetailsViewController.albumCoverImageURL = response?.coverImageURL
                    albumDetailsViewController.album = album
                    albumDetailsViewController.track = track
                    albumDetailsViewController.albumTracks = tracks
                    
                    self?.present(albumDetailsViewController, animated: true, completion: nil)
                    
                    cell.activityIndicator.isHidden = true
                    cell.activityIndicator.stopAnimating()
                }
            } else {
                print("Error message: \(error as Any)")
            }
        })
    }
    
    @objc private func showMenu() {
        let alert = UIAlertController(title: "Select sort type", message: nil, preferredStyle: .actionSheet)
        
        let positionDesc = UIAlertAction(title: "Position Desc", style: .default, handler: { [weak self] action in
            self?.sortTracks(sortType: 0)
        })
        let durationDesc = UIAlertAction(title: "Duration Desc", style: .default, handler: { [weak self] action in
            self?.sortTracks(sortType: 1)
        })
        let durationAsc = UIAlertAction(title: "Duration Asc", style: .default, handler: { [weak self] action in
            self?.sortTracks(sortType: 2)
        })
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        alert.addAction(positionDesc)
        alert.addAction(durationDesc)
        alert.addAction(durationAsc)
        alert.addAction(cancel)

        self.present(alert, animated: true, completion: nil)
    }
    
    private func sortTracks(sortType: Int) {
        switch sortType {
        case 0:
            tracks = tracks.sorted(by: {
                guard let pos0 = $0.position, let pos1 = $1.position else { return false }
                return pos0 < pos1
            })
            break
        case 1:
            tracks = tracks.sorted(by: { $0.duration > $1.duration })
            break
        case 2:
            tracks = tracks.sorted(by: { $0.duration < $1.duration })
            break
        default:
            break
        }
        tableView.reloadData()
    }
}

extension ChartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let cell = tableView.cellForRow(at: indexPath) as? ChartTableViewCell else { return }
        cell.activityIndicator.isHidden = false
        cell.activityIndicator.startAnimating()
        
        let track = tracks[indexPath.row]
        
        guard let album = track.album else { return }
        
        showAlbumInfo(album: album, for: track, cell: cell)
    }
}

extension ChartViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let track = tracks[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: ChartTableViewCell.cellIdentifier) as! ChartTableViewCell
        cell.configure(with: track)
        
        return cell
    }
}
