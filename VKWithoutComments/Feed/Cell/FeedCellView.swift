//
//  FeedCellView.swift
//  VKWithoutComments
//
//  Created by Ruslan Gallyamov on 26.08.2021.
//

import Foundation
import UIKit

class FeedCellView: UITableViewCell {
    
    static let reuseId = "FeedCellView_ID"
    
    let cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    let headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let iconImageView: CacheImageView = {
        let image = CacheImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = image.layer.frame.height / 2
        image.clipsToBounds = true
        return image
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var postLabelHeightConstraint: NSLayoutConstraint?
    let postLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = FeedCellFont.postLabelFont
        return label
    }()
    
    var postImageHeightConstraint: NSLayoutConstraint?
    let postImageView: CacheImageView = {
        let imageView = CacheImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let footerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let likesView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let likesImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "heart")
        return image
    }()
    
    let likesCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let viewsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let viewsImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "eye")
        return image
    }()
    
    let viewsCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "54K"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func prepareForReuse() {
        postImageHeightConstraint?.constant = 0
        postImageView.image = nil
    }
    
    func configure(viewModel: FeedCellViewModel) {
        iconImageView.set(url: viewModel.iconUrl)
        nameLabel.text = viewModel.name
        dateLabel.text = viewModel.date
        likesCountLabel.text = viewModel.likesCount
        viewsCountLabel.text = viewModel.viewsCount
        
        if let postText = viewModel.postText {
            postLabelHeightConstraint?.constant = viewModel.sizes.postSize.height
            postLabel.text = postText
        }

        if let photo = viewModel.postImage {
            postImageHeightConstraint?.constant = viewModel.sizes.imageSize.height
            postImageView.set(url: photo.url)
        }
    }
    
    private func setupLayout() {
        addSubview(cardView)
        cardView.fillSuperview(padding: FeedCellConstraints.Card.insets)
        
        setupHeaderLayout()
        setupFooterLayout()
        setupPostLabelLayout()
        setupPostImageLayout()
    }
    
    private func setupHeaderLayout() {
        cardView.addSubview(headerView)
        headerView.addSubview(iconImageView)
        headerView.addSubview(nameLabel)
        headerView.addSubview(dateLabel)
        
        //Header constraints
        headerView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: FeedCellConstraints.Header.topMargin).isActive = true
        headerView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: FeedCellConstraints.Header.leadingMargin).isActive = true
        headerView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -FeedCellConstraints.Header.trailingMargin).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: FeedCellConstraints.Header.height).isActive = true
        
        //Icon Image View constraints
        iconImageView.anchor(top: headerView.topAnchor, leading: headerView.leadingAnchor, bottom: nil, trailing: nil,
                             size: CGSize(width: FeedCellConstraints.Header.IconImage.height, height: FeedCellConstraints.Header.IconImage.width))
        
        //Name Label constraints
        nameLabel.topAnchor.constraint(equalTo: headerView.topAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: FeedCellConstraints.Header.Name.leadingMargin).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -FeedCellConstraints.Header.Name.trailingMargin).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: FeedCellConstraints.Header.Name.height).isActive = true
        
        //Date Label constraints
        dateLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: FeedCellConstraints.Header.Date.leadingMargin).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -FeedCellConstraints.Header.Date.trailingMargin).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: FeedCellConstraints.Header.Date.height).isActive = true

    }
    
    private func setupPostLabelLayout() {
        cardView.addSubview(postLabel)
        postLabel.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: FeedCellConstraints.PostText.topMargin).isActive = true
        postLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: FeedCellConstraints.PostText.leadingMargin).isActive = true
        postLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -FeedCellConstraints.PostText.trailingMargin).isActive = true
        
        postLabelHeightConstraint = postLabel.heightAnchor.constraint(equalToConstant: 100)
        postLabelHeightConstraint?.isActive = true
    }
    
    private func setupPostImageLayout() {
        cardView.addSubview(postImageView)
        postImageView.bottomAnchor.constraint(equalTo: footerView.topAnchor, constant: -FeedCellConstraints.PostImage.bottomMargin).isActive = true
        postImageView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: FeedCellConstraints.PostImage.leadingMargin).isActive = true
        postImageView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -FeedCellConstraints.PostImage.trailingMargin).isActive = true
        
        postImageHeightConstraint = postImageView.heightAnchor.constraint(equalToConstant: 1)
        postImageHeightConstraint?.isActive = true
    }
    
    private func setupFooterLayout() {
        cardView.addSubview(footerView)
        footerView.addSubview(likesView)
        footerView.addSubview(viewsView)
        
        likesView.addSubview(likesImageView)
        likesView.addSubview(likesCountLabel)
        
        viewsView.addSubview(viewsImageView)
        viewsView.addSubview(viewsCountLabel)

        //Footer constraints
        footerView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -FeedCellConstraints.Footer.bottomMargin).isActive = true
        footerView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: FeedCellConstraints.Footer.leadingMargin).isActive = true
        footerView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: FeedCellConstraints.Footer.trailingMargin).isActive = true
        footerView.heightAnchor.constraint(equalToConstant: FeedCellConstraints.Footer.height).isActive = true
        
        //Likes View constraints
        likesView.anchor(top: footerView.topAnchor, leading: footerView.leadingAnchor, bottom: footerView.bottomAnchor, trailing: nil)
        likesView.widthAnchor.constraint(equalTo: footerView.widthAnchor, multiplier: 0.25).isActive = true
        
        likesImageView.centerYAnchor.constraint(equalTo: likesView.centerYAnchor).isActive = true
        likesImageView.leadingAnchor.constraint(equalTo: likesView.leadingAnchor, constant: FeedCellConstraints.Footer.Likes.imageLeadingMargin).isActive = true
        likesImageView.widthAnchor.constraint(equalToConstant: FeedCellConstraints.Footer.Likes.imageWidth).isActive = true
        likesImageView.heightAnchor.constraint(equalToConstant: FeedCellConstraints.Footer.Likes.imageHeight).isActive = true

        likesCountLabel.centerYAnchor.constraint(equalTo: likesView.centerYAnchor).isActive = true
        likesCountLabel.leadingAnchor.constraint(equalTo: likesImageView.trailingAnchor, constant: FeedCellConstraints.Footer.Likes.textLeadingMargin).isActive = true
        
        //Views View constraints
        viewsView.anchor(top: footerView.topAnchor, leading: nil, bottom: footerView.bottomAnchor, trailing: footerView.trailingAnchor)
        viewsView.widthAnchor.constraint(equalTo: footerView.widthAnchor, multiplier: 0.25).isActive = true
        
        viewsImageView.centerYAnchor.constraint(equalTo: viewsView.centerYAnchor).isActive = true
        viewsImageView.trailingAnchor.constraint(equalTo: viewsCountLabel.leadingAnchor, constant: -FeedCellConstraints.Footer.Views.imageTrailingMargin).isActive = true
        viewsImageView.widthAnchor.constraint(equalToConstant: FeedCellConstraints.Footer.Views.imageWidth).isActive = true
        viewsImageView.heightAnchor.constraint(equalToConstant: FeedCellConstraints.Footer.Views.imageHeight).isActive = true

        viewsCountLabel.centerYAnchor.constraint(equalTo: viewsView.centerYAnchor).isActive = true
        viewsCountLabel.trailingAnchor.constraint(equalTo: viewsView.trailingAnchor, constant: -FeedCellConstraints.Footer.Views.textTrailingMargin).isActive = true
    }
}
