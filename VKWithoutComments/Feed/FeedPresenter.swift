//
//  FeedPresenter.swift
//  VKWithoutComments
//
//  Created by Ruslan Gallyamov on 24.08.2021.
//

import Foundation

protocol FeedPresentationLogic {
    func presentFetchedFeed(response: Feed.FetchFeed.Response)
    func presentFetchedUser(response: Feed.FetchUser.Response)
    func presentFullSizedPost(response: Feed.ShowMore.Response)
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
    
    func presentFetchedUser(response: Feed.FetchUser.Response) {
        let user = response.userResponse
        let headerViewViewModel = Feed.FetchUser.ViewModel.HeaderView(avatarUrl: user.photo100 ?? "")
        viewController?.displayFetchedUser(viewModel: Feed.FetchUser.ViewModel(headerView: headerViewViewModel))
    }
    
    func presentFullSizedPost(response: Feed.ShowMore.Response) {
        let feed = response.feedResponse
        let fullSizedPostIds = response.fullSizedPostIds
        let viewModelCells = feed.items.map { makeViewModelCell(feedItem: $0, profiles: feed.profiles, groups: feed.groups, fullSizedPostIds: fullSizedPostIds) }
        viewController?.displayFetchedFeed(viewModel: Feed.FetchFeed.ViewModel(feedCells: viewModelCells))
    }
    
    private func makeViewModelCell(feedItem: FeedItem, profiles: [Profile], groups: [Group], fullSizedPostIds: [Int] = []) -> Feed.FeedCell {
        let source = getSource(for: feedItem, in: profiles + groups)
        let isFullSizedPost = fullSizedPostIds.contains{ $0 == feedItem.postId }
        
        let imageUrl = source?.photoUrl ?? ""
        let name = source?.name ?? "Unknown"
        let date = getDate(feedItem: feedItem)
        let postText = feedItem.text
        let likesCount = "\(feedItem.likes?.count ?? 0)"
        let viewsCount = "\(feedItem.views?.count ?? 0)"
        let postImages = getPostImages(feedItem: feedItem)
        let sizes = getSizes(postText: postText, postImages: postImages, isFullSizedPost: isFullSizedPost)

        return Feed.FeedCell(postId: feedItem.postId,
                             iconUrl: imageUrl,
                             name: name,
                             date: date,
                             postText: postText,
                             likesCount: likesCount,
                             viewsCount: viewsCount,
                             postImages: postImages,
                             sizes: sizes)
    }
    
    private func getDate(feedItem: FeedItem) -> String {
        let feedItemDate = Date(timeIntervalSince1970: feedItem.date)
        return dateFormatter.string(from: feedItemDate)
    }
    
    private func getSource(for feedItem: FeedItem, in source: [SourceRepresentable]) -> SourceRepresentable? {
        source.first{ abs(feedItem.sourceId) == $0.id }
    }
    
    private func getPostImages(feedItem: FeedItem) -> [FeedCellPostImageViewModel] {
        guard let attachments = feedItem.attachments else { return [] }
        let photos = attachments.compactMap { attachment -> Feed.FeedCellPostImage? in
            guard let photo = attachment.photo else { return nil }
            return Feed.FeedCellPostImage(url: photo.defaultUrl, height: photo.defaultHeight, width: photo.defaultWidth)
        }
        return photos
    }
    
    private func getSizes(postText: String?, postImages: [FeedCellPostImageViewModel], isFullSizedPost: Bool) -> FeedCellSizes {
        sizesCalculator.calculateSize(postText: postText, postImages: postImages, isFullSizedPost: isFullSizedPost)
    }
}
