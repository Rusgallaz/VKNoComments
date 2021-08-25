//
//  FeedInteractor.swift
//  VKWithoutComments
//
//  Created by Ruslan Gallyamov on 24.08.2021.
//

import Foundation

protocol FeedBusinessLogic: AnyObject {
    func fetchFeed(request: Feed.FetchFeed.Request)
}

class FeedInteractor: FeedBusinessLogic {
    var presenter: FeedPresentationLogic?
    
    private var dataFetcher: DataFetcher = NetworkDataFetcher()
    
    func fetchFeed(request: Feed.FetchFeed.Request) {
        dataFetcher.fetchFeed { [weak self] feedResponse in
            guard let feedResponse = feedResponse else { print("Can't get feed response"); return }
            self?.presenter?.presentFetchedFeed(response: Feed.FetchFeed.Response(feedResponse: feedResponse))
        }
    }
}
