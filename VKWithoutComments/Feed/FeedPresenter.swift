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
    
    private var sizesCalculator: FeedCellSizesCalculator = FeedCellSizesCalculatorImpl()
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
        let source = getSource(for: feedItem, in: profiles + groups)
        
        let imageUrl = source?.photoUrl ?? ""
        let name = source?.name ?? "Unknown"
        let date = getDate(feedItem: feedItem)
        let postText = feedItem.text ?? ""
        let likesCount = "\(feedItem.likes?.count ?? 0)"
        let viewsCount = "\(feedItem.views?.count ?? 0)"
        let postImage = getPostImage(feedItem: feedItem)
        let sizes = getSizes(feedItem: feedItem)

        return Feed.FetchFeed.ViewModel.FeedCell(iconUrl: imageUrl, name: name, date: date, postText: postText, likesCount: likesCount, viewsCount: viewsCount, postImage: postImage, sizes: sizes)
    }
    
    private func getDate(feedItem: FeedItem) -> String {
        let feedItemDate = Date(timeIntervalSince1970: feedItem.date)
        return dateFormatter.string(from: feedItemDate)
    }
    
    private func getSource(for feedItem: FeedItem, in source: [SourceRepresentable]) -> SourceRepresentable? {
        source.first{ abs(feedItem.sourceId) == $0.id }
    }
    
    private func getPostImage(feedItem: FeedItem) -> FeedCellPostImageViewModel? {
        if let attachmentPhoto = feedItem.attachments?.first(where: { $0.type == "photo" }), let photo = attachmentPhoto.photo {
            return Feed.FetchFeed.ViewModel.FeedCellPostImage(url: photo.defaultUrl, height: photo.defaultHeight, width: photo.defaultWidth)
        } else {
            return nil
        }
    }
    
    private func getSizes(feedItem: FeedItem) -> FeedCellSizes {
        sizesCalculator.calculateSize()
    }
}
