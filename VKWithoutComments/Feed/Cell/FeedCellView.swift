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
    
    weak var delegate: FeedCellDelegate?
        
    // MARK: UI elements
    private let cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private let headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let iconImageView: CacheImageView = {
        let image = CacheImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = FeedCellConstraints.Header.IconImage.height / 2
        image.clipsToBounds = true
        return image
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = FeedCellFont.nameLabelFont
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = FeedCellFont.dateLabelFont
        label.textColor = .secondaryLabel
        return label
    }()
    
    private var postLabelHeightConstraint: NSLayoutConstraint?
    private let postLabel: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = FeedCellFont.postLabelFont
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.isSelectable = true
        textView.isUserInteractionEnabled = true
        textView.dataDetectorTypes = .all
        
        let padding = textView.textContainer.lineFragmentPadding
        textView.textContainerInset = UIEdgeInsets(top: 0, left: -padding, bottom: 0, right: -padding)
        return textView
    }()
    
    private var moreButtonHeightConstraint: NSLayoutConstraint?
    private let moreButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = FeedCellFont.moreButtonFont
        button.setTitleColor(.blue, for: .normal)
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .leading
        button.setTitle("Show more...", for: .normal)
        button.clipsToBounds = true
        return button
    }()
    
    private var photoCollectionViewHeightConstraint: NSLayoutConstraint?
    private let photoCollectionView: PhotoCollectionView = {
        let view = PhotoCollectionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let footerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let likesView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let likesImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "heart")
        image.tintColor = .secondaryLabel
        return image
    }()
    
    private let likesCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = FeedCellFont.bottomViewFont
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let viewsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let viewsImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "eye")
        image.tintColor = .secondaryLabel
        return image
    }()
    
    private let viewsCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = FeedCellFont.bottomViewFont
        label.textColor = .secondaryLabel
        return label
    }()
    
    //MARK: Configuration
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        backgroundColor = .clear
        selectionStyle = .none
        moreButton.addTarget(self, action: #selector(moreButtonPressed), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        iconImageView.image = nil
        postLabel.text = nil

        postLabelHeightConstraint?.constant = 0
        photoCollectionViewHeightConstraint?.constant = 0
        moreButtonHeightConstraint?.constant = 0
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
        
        if !viewModel.postImages.isEmpty {
            photoCollectionViewHeightConstraint?.constant = viewModel.sizes.imageSize.height
            photoCollectionView.set(viewModel.postImages)
        }
        
        if viewModel.sizes.moreButtonSize != .zero {
            moreButtonHeightConstraint?.constant = viewModel.sizes.moreButtonSize.height
        }
    }
    
    // MARK: Setup layout
    private func setupLayout() {
        self.contentView.addSubview(cardView)
        cardView.fillSuperview(padding: FeedCellConstraints.Card.insets)
        
        setupHeaderLayout()
        setupFooterLayout()
        setupPostLabelLayout()
        setupMoreButtonLayout()
        setupPhotoCollectionViewLayout()
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
        
        postLabelHeightConstraint = postLabel.heightAnchor.constraint(equalToConstant: 0)
        postLabelHeightConstraint?.isActive = true
    }
    
    private func setupMoreButtonLayout() {
        cardView.addSubview(moreButton)
        moreButton.topAnchor.constraint(equalTo: postLabel.bottomAnchor, constant: FeedCellConstraints.MoreButton.topMargin).isActive = true
        moreButton.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: FeedCellConstraints.MoreButton.leadingMargin).isActive = true
        moreButton.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -FeedCellConstraints.MoreButton.trailingMargin).isActive = true
        
        moreButtonHeightConstraint = moreButton.heightAnchor.constraint(equalToConstant: 0)
        moreButtonHeightConstraint?.isActive = true
    }
    
    private func setupPhotoCollectionViewLayout() {
        cardView.addSubview(photoCollectionView)
        photoCollectionView.bottomAnchor.constraint(equalTo: footerView.topAnchor, constant: -FeedCellConstraints.PostImage.bottomMargin).isActive = true
        photoCollectionView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: FeedCellConstraints.PostImage.leadingMargin).isActive = true
        photoCollectionView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -FeedCellConstraints.PostImage.trailingMargin).isActive = true
        
        photoCollectionViewHeightConstraint = photoCollectionView.heightAnchor.constraint(equalToConstant: 0)
        photoCollectionViewHeightConstraint?.isActive = true
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
    
    //MARK: Actions
    @objc func moreButtonPressed() {
        delegate?.moreButtonPressedInCell(self)
    }
}
