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
    
    private var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM HH:mm"
        return dateFormatter
    }()
    
    func presentFetchedFeed(response: Feed.FetchFeed.Response) {
        let feed = response.feedResponse
        let viewModelCells = feed.items.map { makeViewModelCell(feedItem: $0, profiles: feed.profiles, groups: feed.groups) }
        viewController?.displayFetchedFeed(viewModel: Feed.FetchFeed.ViewModel(feedCells: viewModelCells))
    }
    
    private func makeViewModelCell(feedItem: FeedItem, profiles: [Profile], groups: [Group]) -> Feed.FetchFeed.ViewModel.FeedCell {
        let source = findSource(for: feedItem, in: profiles + groups)
        
        let imageUrl = source?.photoUrl ?? ""
        let name = source?.name ?? "Unknown"
        let date = dateFormatter.string(from: Date(timeIntervalSince1970: feedItem.date))
        let postText = feedItem.text ?? ""
        let likesCount = "\(feedItem.likes?.count ?? 0)"
        let viewsCount = "\(feedItem.views?.count ?? 0)"
        return Feed.FetchFeed.ViewModel.FeedCell(iconUrl: imageUrl, name: name, date: date, postText: postText, likesCount: likesCount, viewsCount: viewsCount)
    }
    
    private func findSource(for feedItem: FeedItem, in source: [SourceRepresentable]) -> SourceRepresentable? {
        source.first{ abs(feedItem.sourceId) == $0.id }
    }
}
