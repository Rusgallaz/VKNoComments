//
//  SearchTextField.swift
//  VKWithoutComments
//
//  Created by Ruslan Gallyamov on 28.08.2021.
//

import Foundation
import UIKit

class SearchTextField: UITextField {
    
    private var leftViewPadding: CGFloat {
        return 12
    }
    
    private var textPadding: CGFloat {
        return 36
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSearchField()
        setupLeftView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.leftViewRect(forBounds: bounds)
        rect.origin.x += leftViewPadding
        return rect
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: textPadding, dy: 0)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: textPadding, dy: 0)
    }
    
    private func setupSearchField() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        placeholder = "Search"
        font = UIFont.systemFont(ofSize: 14)
        clearButtonMode = .whileEditing
        borderStyle = .none
        layer.cornerRadius = 10
        layer.masksToBounds = true
    }
    
    private func setupLeftView() {
        let image = UIImage(systemName: "magnifyingglass")
        leftView = UIImageView(image: image)
        leftView?.tintColor = .secondaryLabel
        leftView?.frame = CGRect(x: 0, y: 0, width: 14, height: 14)
        leftViewMode = .always
    }
}
