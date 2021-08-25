//
//  FeedPresenter.swift
//  VKWithoutComments
//
//  Created by Ruslan Gallyamov on 24.08.2021.
//

import Foundation

protocol FeedPresentationLogic {
    func presentFetchedFeed(response: Feed.FetchFeed.Response)
}

class FeedPresenter: FeedPresentationLogic {
    weak var viewController: FeedDisplayLogic?
    
    func presentFetchedFeed(response: Feed.FetchFeed.Response) {
        let viewModelCells = response.feedResponse.items.map { makeViewModelCellFrom(feedItem: $0) }
        viewController?.displayFetchedFeed(viewModel: Feed.FetchFeed.ViewModel(feedCells: viewModelCells))
    }
    
    private func makeViewModelCellFrom(feedItem: FeedItem) -> Feed.FetchFeed.ViewModel.FeedCell {
        let imageUrl = "Stub"
        let name = "Stub"
        let date = "Stub"
        let postText = feedItem.text ?? ""
        let likesCount = "\(feedItem.likes?.count ?? 0)"
        let viewsCount = "\(feedItem.views?.count ?? 0)"
        return Feed.FetchFeed.ViewModel.FeedCell(iconUrl: imageUrl, name: name, date: date, postText: postText, likesCount: likesCount, viewsCount: viewsCount)
    }
}
