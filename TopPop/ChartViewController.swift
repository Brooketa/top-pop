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
        
        tableView.delegate = self
        tableView.dataSource = self
        
        WebService.fetchTracks(completion: { [weak self] response, error in
            if error == nil {
                if response != nil {
                    guard let tracks = response?.tracksData.tracks else { return }
                    self?.tracks = tracks
                    self?.tableView.reloadData()
                }
            } else {
                print(error as Any)
            }
        })
    }
}

extension ChartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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
