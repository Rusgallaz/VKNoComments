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
    
    private var feedCells = [Feed.FeedCell]()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCleanSwiftComponents()
        
        tableView.register(FeedCellView.self, forCellReuseIdentifier: FeedCellView.reuseId)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        view.backgroundColor = .systemGroupedBackground
        
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
        feedCells[indexPath.row].sizes.cellHeight
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        feedCells[indexPath.row].sizes.cellHeight
    }
}

// MARK: UITableViewDataSource
extension FeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        feedCells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedCellView.reuseId) as! FeedCellView
        cell.configure(viewModel: feedCells[indexPath.row])
        cell.delegate = self
        return cell
    }
}

//MARK: FeedCellDelegate
extension FeedViewController: FeedCellDelegate {
    
    func moreButtonPressedInCell(_ cell: FeedCellView) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let feedCell = feedCells[indexPath.row]
        interactor?.showMoreText(request: Feed.ShowMore.Request(postId: feedCell.postId))
    }
}
