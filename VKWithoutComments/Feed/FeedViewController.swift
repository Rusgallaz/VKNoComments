//
//  FeedViewController.swift
//  VKWithoutComments
//
//  Created by Ruslan Gallyamov on 23.08.2021.
//

import UIKit

protocol FeedDisplayLogic: AnyObject {
    func displayFetchedFeed(viewModel: Feed.FetchFeed.ViewModel)
}

class FeedViewController: UIViewController {
   
    @IBOutlet var tableView: UITableView!
    
    var interactor: FeedBusinessLogic?
    
    private var feedCells = [FeedCellViewModel]()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCleanSwiftComponents()
        tableView.register(UINib(nibName: "FeedCell", bundle: nil), forCellReuseIdentifier: FeedCell.cellId)
        interactor?.fetchFeed(request: Feed.FetchFeed.Request())
    }
    
    private func setupCleanSwiftComponents() {
        let interactor = FeedInteractor()
        let presenter = FeedPresenter()
        self.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = self
    }
}

// MARK: FeedDisplayLogic
extension FeedViewController: FeedDisplayLogic {
    func displayFetchedFeed(viewModel: Feed.FetchFeed.ViewModel) {
        feedCells = viewModel.feedCells
        tableView.reloadData()
    }
}

// MARK: UITableViewDelegate
extension FeedViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        260
    }
}

// MARK: UITableViewDataSource
extension FeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        feedCells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedCell.cellId) as! FeedCell
        cell.configure(viewModel: feedCells[indexPath.row])
        return cell
    }
    
    
}
