//
//  FeedInteractor.swift
//  VKWithoutComments
//
//  Created by Ruslan Gallyamov on 24.08.2021.
//

import Foundation

protocol FeedBusinessLogic: AnyObject {
    func fetchFeed(request: Feed.FetchFeed.Request)
    func showMoreText(request: Feed.ShowMore.Request)
}

class FeedInteractor: FeedBusinessLogic {
    var presenter: FeedPresentationLogic?
    
    private var fetchedFeedResponse: FeedResponse?
    private var fullSizedPostIds = [Int]()
    private var dataFetcher: DataFetcher = NetworkDataFetcher()
    
    func fetchFeed(request: Feed.FetchFeed.Request) {
        dataFetcher.fetchFeed { [weak self] feedResponse in
            guard let feedResponse = feedResponse else { return }
            self?.fetchedFeedResponse = feedResponse
            self?.presenter?.presentFetchedFeed(response: Feed.FetchFeed.Response(feedResponse: feedResponse))
        }
    }
    
    func showMoreText(request: Feed.ShowMore.Request) {
        guard let feedResponse = fetchedFeedResponse else { return }
        fullSizedPostIds.append(request.postId)
        let response = Feed.ShowMore.Response(feedResponse: feedResponse, fullSizedPostIds: fullSizedPostIds)
        presenter?.presentFullSizedPost(response: response)
    }
}
