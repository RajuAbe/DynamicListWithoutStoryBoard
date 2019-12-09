//
//  DetailsTableViewCell.swift
//  DynamicListWithoutStoryBoard
//
//  Created by Raju@MFCWL on 08/12/19.
//  Copyright © 2019 RMS_Mac. All rights reserved.
//

import UIKit
import SDWebImage

class DetailsTableViewCell: UITableViewCell {
    /**
     Profile imageview
        - cornerRadius = 30 (circular)
     */
    var profileImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 30
        image.clipsToBounds = true
        return image
    }()
    /**
        Title label with font size 15
     */
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    /**
        description label with font size 13
     */
    var descriptionLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        
        //label.backgroundColor =  colorLiteral(red: 0.2431372549, green: 0.7647058824, blue: 0.8392156863, alpha: 1)
        //label.numberOfLines = 0
        //label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    // Height constraint for dynamic height
    var descriptionHeightConstraint: NSLayoutConstraint!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.initializeUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        //fatalError("init(coder:) has not been implemented")
    }
    /**
        Initializing the UI
        -
     - Contains all constarints
     */
    private func initializeUI() {
        let marginGuide = contentView.layoutMarginsGuide
        
        self.contentView.addSubview(profileImageView)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(descriptionLabel)
        
        // imageView autolayouts
        profileImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        profileImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        // title Label
        titleLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 5).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor, constant: -10).isActive = true
        
        // DescriptionLabel constraints
        
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        let bottomConstraint = descriptionLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor, constant: -5)
        bottomConstraint.priority = .defaultLow
        bottomConstraint.isActive = true
        descriptionHeightConstraint = descriptionLabel.heightAnchor.constraint(equalToConstant: 17)
        descriptionHeightConstraint.isActive = true
        
    }
    /**
     Configuring `DetailsTableviewCell`
     - Parameter indexPath: UItableview indexpath
     - Parameter rowData row: Rows dynamic value
     - setting image view and all labels value
     */
    internal func configCell(at indexPath: IndexPath, rowData row: Rows) {
        let height = descriptionLabel.heightForLabel(text: row.description ?? "", font: UIFont.systemFont(ofSize: 13), width: contentView.bounds.width-78)
        
        self.titleLabel.text = row.title ?? ""
        descriptionHeightConstraint.constant = height
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        descriptionLabel.text = row.description ?? ""
        descriptionLabel.sizeToFit()
        
        let image = UIImage(named: "no_image")
        if let urlStr = row.imageHref, !urlStr.isEmpty {
            let url = URL(string: String(urlStr))
            
            self.profileImageView.sd_setImage(with: url, placeholderImage: image)
        }
        else {
            self.profileImageView.image = image
        }
    }
}

// MARK:- UILabel Extension for calculating dynamic height
extension UILabel {

    /**
        calulating dynamic height
     - Parameter text: text assigning into label in String format
     - Parameter font: font for the label
     - Parameter width: with of container label
     */
    func heightForLabel(text:String, font:UIFont, width:CGFloat) -> CGFloat {
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text

        label.sizeToFit()
        return label.frame.height
    }

}
