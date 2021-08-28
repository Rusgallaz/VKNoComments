//
//  FeedInteractor.swift
//  VKWithoutComments
//
//  Created by Ruslan Gallyamov on 24.08.2021.
//

import Foundation

protocol FeedBusinessLogic: AnyObject {
    func fetchFeed(request: Feed.FetchFeed.Request)
    func fetchUser(request: Feed.FetchUser.Request)
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
    
    func fetchUser(request: Feed.FetchUser.Request) {
        dataFetcher.fetchUser { [weak self] userResponse in
            guard let userResponse = userResponse else { return }
            self?.presenter?.presentFetchedUser(response: Feed.FetchUser.Response(userResponse: userResponse))
        }
    }
    
    func showMoreText(request: Feed.ShowMore.Request) {
        guard let feedResponse = fetchedFeedResponse else { return }
        fullSizedPostIds.append(request.postId)
        let response = Feed.ShowMore.Response(feedResponse: feedResponse, fullSizedPostIds: fullSizedPostIds)
        presenter?.presentFullSizedPost(response: response)
    }
}
