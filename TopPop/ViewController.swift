//
//  ViewController.swift
//  TopPop
//
//  Created by Brooketa on 14.05.2021..
//

import UIKit

class ChartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        WebService.fetchTracks(completion: { response, error in
            print(response)
        })
        
        WebService.fetchAlbum(albumID: "", completion: { response, error in
            print("\n\n \(response)")
        })
    }
}

