//
//  SearchTextField.swift
//  CeretMobileTAsk
//
//  Created by eslam dweeb on 02/03/2025.
//

import UIKit

import UIKit

class SearchTextField: UITextField {
    private var insets: UIEdgeInsets = .init(top: 0, left: 40, bottom: 0, right: 8) // Adjust left inset to account for the icon
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSearchTextField()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSearchTextField()
    }
    
    private func setupSearchTextField() {
        // Set placeholder text
        self.placeholder = "search Brands"
        
        // Set text color
        self.textColor = .black
        
        // Set font
        self.font = UIFont.systemFont(ofSize: 16)
        
        // Set background color
        self.backgroundColor = .white
        
        // Add a magnifying glass icon on the left
        let searchIcon = UIImage(named: "SearchIcon") // Use your custom icon or system icon
        let iconView = UIImageView(image: searchIcon)
        iconView.tintColor = .gray
        iconView.contentMode = .scaleAspectFit
        iconView.frame = CGRect(x: 8, y: 0, width: 24, height: 24) // Adjust icon size and position
        
        // Create a container view for the icon and padding
        let iconContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: self.frame.height))
        iconView.frame = CGRect(x: 8, y: (iconContainerView.frame.height - 24) / 2, width: 24, height: 24) // Center the icon vertically
        iconContainerView.addSubview(iconView)
        
        // Set the container view as the leftView
        self.leftView = iconContainerView
        self.leftViewMode = .always
        
        // Customize the border
        self.layer.cornerRadius = 8
        
    }
    
    // Adjust the text rect to start after the icon
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }
    
    // Adjust the editing rect to start after the icon
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }
    
    // Adjust the placeholder rect to start after the icon
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }
}
