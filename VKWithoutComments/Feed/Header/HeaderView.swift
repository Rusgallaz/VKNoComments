//
//  HeaderView.swift
//  VKWithoutComments
//
//  Created by Ruslan Gallyamov on 28.08.2021.
//

import Foundation
import UIKit

protocol HeaderViewViewModel {
    var avatarUrl: String { get }
}

class HeaderView: UIView {
    
    override var intrinsicContentSize: CGSize {
        return UIView.layoutFittingExpandedSize
    }
    
    private var defaultPadding: CGFloat {
        return 4
    }
    
    private var searchTextField = SearchTextField()
    private var avatarIconView: CacheImageView = {
        let imageView = CacheImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .orange
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        avatarIconView.layer.masksToBounds = true
        avatarIconView.layer.cornerRadius = avatarIconView.bounds.width / 2
    }
    
    func set(viewModel: HeaderViewViewModel) {
        avatarIconView.set(url: viewModel.avatarUrl)
    }
    
    private func setupLayout() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(searchTextField)
        addSubview(avatarIconView)
        
        avatarIconView.topAnchor.constraint(equalTo: topAnchor, constant: defaultPadding).isActive = true
        avatarIconView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: defaultPadding).isActive = true
        avatarIconView.heightAnchor.constraint(equalTo: searchTextField.heightAnchor, multiplier: 1).isActive = true
        avatarIconView.widthAnchor.constraint(equalTo: searchTextField.heightAnchor, multiplier: 1).isActive = true
        
        searchTextField.anchor(top: topAnchor,
                               leading: leadingAnchor,
                               bottom: bottomAnchor,
                               trailing: avatarIconView.leadingAnchor,
                               padding: UIEdgeInsets(top: defaultPadding, left: defaultPadding, bottom: defaultPadding, right: 12))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
