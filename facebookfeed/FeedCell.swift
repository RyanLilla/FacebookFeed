//
//  FeedCell.swift
//  facebookfeed
//
//  Created by Ryan Lilla on 8/27/19.
//  Copyright © 2019 Ryan Lilla. All rights reserved.
//

import Foundation
import UIKit

class FeedCell: UICollectionViewCell {
    
    // Reference to the FeedController to be used with the animate() function
    var feedController: FeedController?
    
    // Calls on the feedController's animate function in order to animate the image within the entire view
    @objc func animate() {
        feedController?.animateImageView(statusImageView: statusImageView)
    }
    
    // Creates a post with all the necessary components
    var post: Post? {
        didSet {
            if let name = post?.name {
                let attributedText = NSMutableAttributedString(string: name, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
                attributedText.append(NSAttributedString(string: "\nAugust 27 • San Francisco •", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12), NSAttributedString.Key.foregroundColor: UIColor.rgb(red: 155, green: 161, blue: 171)]))
                
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.lineSpacing = 4
                
                attributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedText.string.count))
                
                let attachment = NSTextAttachment()
                attachment.image = UIImage(named: "globe_small")
                attachment.bounds = CGRect(x: 0, y: -2, width: 12, height: 12)
                attributedText.append(NSAttributedString(attachment: attachment))
                
                nameLabel.attributedText = attributedText
            }
            
            if let statusText = post?.statusText {
                statusTextView.text = statusText
            }
            
            if let profileImageName = post?.profileImageName {
                profileImageView.image = UIImage(named: profileImageName)
            }
            
            if let statusImageName = post?.statusImageName {
                statusImageView.image = UIImage(named: statusImageName)
            }
        }
    }
    
    // Name and details for each cell
    let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        
        return label
    }()
    
    // Profile Image
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "zuckprofile")
        return imageView
    }()
    
    // The description for the status update
    let statusTextView: UITextView = {
        let textView = UITextView()
        textView.text = "This is some sample text in a textView"
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.isScrollEnabled = false
        return textView
    }()
    
    // The image shared in the status update
    let statusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "zuckdog")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        
        // Allows events to occur when the image is interacted with?
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    // The label for the likes and comments under each status update
    let likesCommentsLabel: UILabel = {
        let label = UILabel()
        label.text = "487 Likes    10.7K Comments"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.rgb(red: 155, green: 161, blue: 171)
        return label
    }()
    
    // Divider between each cell
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 226, green: 228, blue: 232)
        return view
    }()
    
    // Like button for each cell
    let likeButton: UIButton = FeedCell.buttonForTitle(titleName: "Like", imageName: "like")
    let commentButton: UIButton = FeedCell.buttonForTitle(titleName: "Comment", imageName: "comment")
    let shareButton: UIButton = FeedCell.buttonForTitle(titleName: "Share", imageName: "share")
    
    static func buttonForTitle(titleName: String, imageName: String) -> UIButton {
        let button = UIButton()
        button.setTitle(titleName, for: .normal)
        button.setTitleColor(UIColor.rgb(red: 143, green: 150, blue: 163), for: .normal)
        button.setImage(UIImage(named: imageName), for: .normal)
        
        // Creates spacing between the button title and the button image
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Sets up and adds the necessary view to the super view
    func setupViews() {
        backgroundColor = .white
        
        addSubview(nameLabel)
        addSubview(profileImageView)
        addSubview(statusTextView)
        addSubview(statusImageView)
        addSubview(likesCommentsLabel)
        
        addSubview(dividerLineView)
        
        addSubview(likeButton)
        addSubview(commentButton)
        addSubview(shareButton)
        
        // Adds a tap gesture recognizer to the statusImageView
        statusImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector(("animate"))))
        
        // Horizontal Constraints
        addContraintsWithFormat(format: "H:|-8-[v0(44)]-8-[v1]|", views: profileImageView, nameLabel)
        addContraintsWithFormat(format: "H:|-4-[v0]-4-|", views: statusTextView)
        addContraintsWithFormat(format: "H:|[v0]|", views: statusImageView)
        addContraintsWithFormat(format: "H:|-12-[v0]|", views: likesCommentsLabel)
        addContraintsWithFormat(format: "H:|-12-[v0]-12-|", views: dividerLineView)
        addContraintsWithFormat(format: "H:|[v0(v2)][v1(v2)][v2]|", views: likeButton, commentButton, shareButton)
        
        // Vertical Constraints
        addContraintsWithFormat(format: "V:|-12-[v0]", views: nameLabel)
        addContraintsWithFormat(format: "V:|-8-[v0(44)]-4-[v1]-4-[v2(200)]-8-[v3(24)]-8-[v4(0.4)][v5(44)]|", views: profileImageView, statusTextView, statusImageView, likesCommentsLabel, dividerLineView, likeButton)
        addContraintsWithFormat(format: "V:[v0(44)]|", views: commentButton)
        addContraintsWithFormat(format: "V:[v0(44)]|", views: shareButton)
    }
    
}


extension UIColor {
    
    // An extension for changing the rgb color quickly
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(displayP3Red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}


extension UIView {
    
    // Custom extension to format a constraint within the view
    func addContraintsWithFormat(format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
}

