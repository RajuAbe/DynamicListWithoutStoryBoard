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
    
    var profileImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 30
        image.clipsToBounds = true
        return image
    }()
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var descriptionLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        
        //label.backgroundColor =  colorLiteral(red: 0.2431372549, green: 0.7647058824, blue: 0.8392156863, alpha: 1)
        //label.numberOfLines = 0
        //label.lineBreakMode = .byWordWrapping
        label.backgroundColor = UIColor.yellow
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var labelContainerView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true // this will make sure its children do not go out of the boundary
        view.backgroundColor = UIColor.lightGray
        return view
    }()
    
    
    
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
    
    private func initializeUI() {
        let marginGuide = contentView.layoutMarginsGuide
        
        self.contentView.addSubview(profileImageView)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(descriptionLabel)
//        addSubview(profileImageView)
//        addSubview(labelContainerView)
//        addSubview(titleLabel)
//        addSubview(descriptionLabel)
        
        // imageView autolayouts
        profileImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        profileImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        // ContainerView autoLayouts
        /*
        labelContainerView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8).isActive = true
        labelContainerView.leadingAnchor.constraint(equalToSystemSpacingAfter: profileImageView.trailingAnchor, multiplier: 10).isActive = true
        labelContainerView.trailingAnchor.constraint(equalToSystemSpacingAfter: self.contentView.trailingAnchor, multiplier: 10).isActive = true
        labelContainerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 5).isActive = true
        */
        // title Label
        titleLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 5).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor, constant: -10).isActive = true
        
        // DescriptionLabel constraints
        
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor, constant: -10).isActive = true
    }
    
    internal func configCell(at indexPath: IndexPath, rowData row: Rows) {
        let height = descriptionLabel.heightForLabel(text: row.description ?? "", font: UIFont.systemFont(ofSize: 14), width: contentView.bounds.width-60)
        self.titleLabel.text = row.title ?? ""
        //self.descriptionLabel.text = description
        descriptionLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
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
        print("New height \(height)")
        if height == 0 {
            
        }
        
    }
}

extension UILabel {

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
