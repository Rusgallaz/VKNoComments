//
//  FeedViewCell.swift
//  VKWithoutComments
//
//  Created by Ruslan Gallyamov on 25.08.2021.
//

import UIKit

protocol FeedCellViewModel {
    var iconUrl: String { get }
    var name: String { get }
    var date: String { get }
    var postText: String { get }
    var likesCount: String { get }
    var viewsCount: String { get }
}

class FeedCell: UITableViewCell {
    
    static let cellId = "FeedCellId"

    @IBOutlet var IconImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var postTextLabel: UILabel!
    @IBOutlet var likesCountLabel: UILabel!
    @IBOutlet var viewsCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(viewModel: FeedCellViewModel) {
        nameLabel.text = viewModel.name
        dateLabel.text = viewModel.date
        postTextLabel.text = viewModel.postText
        likesCountLabel.text = viewModel.likesCount
        viewsCountLabel.text = viewModel.viewsCount
    }

}
