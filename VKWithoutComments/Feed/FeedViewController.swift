//
//  FeedViewController.swift
//  VKWithoutComments
//
//  Created by Ruslan Gallyamov on 23.08.2021.
//

import UIKit

class FeedViewController: UIViewController {

    private let dataFetcher: DataFetcher = DataFetcherImpl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        
        dataFetcher.fetchFeed { response in
            guard let response = response else { return }
            response.items.forEach { print($0.text) }
        }
        // Do any additional setup after loading the view.
    }

}
