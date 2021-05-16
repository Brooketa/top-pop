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
        navigationItem.rightBarButtonItem = menuButton
        
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
    
    @objc private func showMenu() {
        let alert = UIAlertController(title: "Select sort type", message: nil, preferredStyle: .actionSheet)
        
        let positionDesc = UIAlertAction(title: "Position descending", style: .default, handler: { [weak self] action in
            self?.sortTracks(sortType: 0)
        })
        let durationDesc = UIAlertAction(title: "Duration descending", style: .default, handler: { [weak self] action in
            self?.sortTracks(sortType: 1)
        })
        let durationAsc = UIAlertAction(title: "Duration ascending", style: .default, handler: { [weak self] action in
            self?.sortTracks(sortType: 2)
        })
        
        alert.addAction(positionDesc)
        alert.addAction(durationDesc)
        alert.addAction(durationAsc)

        self.present(alert, animated: true, completion: nil)
    }
    
    private func sortTracks(sortType: Int) {
        switch sortType {
        case 0:
            tracks = tracks.sorted(by: { $0.position! < $1.position! })
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
