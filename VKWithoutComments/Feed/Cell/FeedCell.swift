//
//  FeedViewCell.swift
//  VKWithoutComments
//
//  Created by Ruslan Gallyamov on 25.08.2021.
//

import UIKit

class FeedCell: UITableViewCell {
    
    static let cellId = "FeedCellId"

    @IBOutlet var cardView: UIView!
    @IBOutlet var iconImageView: CacheImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var postTextLabel: UILabel!
    @IBOutlet var postImageView: CacheImageView!
    @IBOutlet var likesCountLabel: UILabel!
    @IBOutlet var viewsCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .clear
        selectionStyle = .none
        
        iconImageView.layer.cornerRadius = iconImageView.frame.height / 2
        iconImageView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(viewModel: FeedCellViewModel) {
        iconImageView.set(url: viewModel.iconUrl)
        nameLabel.text = viewModel.name
        dateLabel.text = viewModel.date
        postTextLabel.text = viewModel.postText
        likesCountLabel.text = viewModel.likesCount
        viewsCountLabel.text = viewModel.viewsCount
        
//        postTextLabel.frame = viewModel.sizes.postSize
        
        print(postTextLabel.frame)
        
        if let postImage = viewModel.postImage {
            postImageView.set(url: postImage.url)
            postImageView.isHidden = false
        } else {
            postImageView.isHidden = true
        }
    }

}
