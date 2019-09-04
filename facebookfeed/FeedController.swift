//
//  ViewController.swift
//  facebookfeed
//
//  Created by Ryan Lilla on 8/27/19.
//  Copyright © 2019 Ryan Lilla. All rights reserved.
//

import UIKit

let cellId = "cellId"

class FeedController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var posts = [Post]()
    
    // Views that will be used when an image is zoomed in/out
    let zoomImageView = UIImageView()
    let blackBackgroundView = UIView()
    let navBarCoverView = UIView()
    let tabBarCoverView = UIView()
    
    // The image that is displayed
    var statusImageView: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let postMark = Post()
        postMark.name = "Mark Zuckerberg"
        postMark.profileImageName = "zuckprofile"
        postMark.statusText = "Hi, I'm Mark Zuckerberg and this is my dog!"
        postMark.statusImageName = "zuckdog"
        postMark.numLikes = 123
        postMark.numComments = 1342
        
        let postSteve = Post()
        postSteve.name = "Steve Jobs"
        postSteve.profileImageName = "steve_profile"
        postSteve.statusText = "Together with Woz, we created Apple. Blah blah blah blah blahhhhhhrk Zuckerberg and this is my dog!"
        postSteve.statusImageName = "steve_status"
        postSteve.numLikes = 312
        postSteve.numComments = 753465
        
        posts.append(postMark)
        posts.append(postSteve)
        
        navigationItem.title = "Facebook Feed"
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        
        // Registers a FeedCell using the cellId as an identifier
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: cellId)
    }

    // Denotes the number of items displayed within the FeeController
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    // Returns the cell for a specific items at an indexPath
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let feedCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! FeedCell
        
        feedCell.post = posts[indexPath.item]
        feedCell.feedController = self
        
        return feedCell
    }
    
    // Sets the size of each cell within the FeedController view
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if let statusText = posts[indexPath.item].statusText {
            
            // Returns the height of the statusText string
            let rect = NSString(string: statusText).boundingRect(with: CGSize(width: view.frame.width, height: 1000), options: NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin), attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)], context: nil)
            
            let knownHeight: CGFloat = 8 + 44 + 4 + 4 + 200 + 8 + 24 + 8 + 44
            return CGSize(width: view.frame.width, height: rect.height + knownHeight + 24)
        }
        
        return CGSize(width: view.frame.width, height: 500)
    }
    
    // When the view changes, invalidate the layout and redraw it -- Allows for both screen orientations
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    // Animates the status image when it is clicked on
    func animateImageView(statusImageView: UIImageView) {
        
        self.statusImageView = statusImageView
        
        // Gets the image's absolute starting coordinates for the frame
        if let startingFrame = statusImageView.superview?.convert(statusImageView.frame, to: nil) {
            
            // Hides the orginal image so it isn't visible during the animation
            statusImageView.alpha = 0
            
            // Sets the black background to take up the entire view
            blackBackgroundView.frame = self.view.frame
            blackBackgroundView.backgroundColor = .black
            blackBackgroundView.alpha = 0
            view.addSubview(blackBackgroundView)
            
            // Sets the view to be the same size as the navbar
            navBarCoverView.frame = CGRect(x: 0, y: 0, width: 1000, height: 44 + 44)
            navBarCoverView.backgroundColor = .black
            navBarCoverView.alpha = 0
            
            if let keyWindow = UIApplication.shared.keyWindow {
                
                // Creates a frame the size of the tab bar
                // Parameters:
                //  - 49: the pixels in size of the tab bar
                //  - 34: the pixels in size of the space below it
                tabBarCoverView.frame = CGRect(x: 0, y: keyWindow.frame.height - 49 - 34, width: 1000, height: 49 - 34)
                tabBarCoverView.backgroundColor = .black
                tabBarCoverView.alpha = 0
                
                // Adds the subviews
                keyWindow.addSubview(tabBarCoverView)
                keyWindow.addSubview(navBarCoverView)
            }
            
            // Create the image to be animated
            zoomImageView.backgroundColor = .red
            zoomImageView.frame = startingFrame
            zoomImageView.isUserInteractionEnabled = true
            zoomImageView.image = statusImageView.image
            zoomImageView.contentMode = .scaleAspectFill
            zoomImageView.clipsToBounds = true
            
            // Adds the image to the view
            view.addSubview(zoomImageView)
            
            // Zooms out when the image is clicked again
            zoomImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector(("zoomOut"))))
            
            // Animates the image by moving it to the new location in the center of the screen
            UIView.animate(withDuration: 0.75) {
                let height = (self.view.frame.width / startingFrame.width) * startingFrame.height
                let y = self.view.frame.height / 2 - height / 2
                self.zoomImageView.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: height)
                
                self.blackBackgroundView.alpha = 1
                self.navBarCoverView.alpha = 1
                self.tabBarCoverView.alpha = 1
            }
        }
    }
    
    // Function that zooms out the image back to its original location
    @objc func zoomOut() {
        
        // The starting frame of the zoomed in image
        if let startingFrame = statusImageView!.superview?.convert(statusImageView!.frame, to: nil) {
            
            // Animates the image, moving it back to its original location and removing the black background
            UIView.animate(withDuration: 0.75, animations: {
                self.zoomImageView.frame = startingFrame
                self.blackBackgroundView.alpha = 0
                self.navBarCoverView.alpha = 0
                self.tabBarCoverView.alpha = 0
            }) { (didComplete) in
                self.zoomImageView.removeFromSuperview()
                self.blackBackgroundView.removeFromSuperview()
                self.navBarCoverView.removeFromSuperview()
                self.tabBarCoverView.removeFromSuperview()
                self.statusImageView?.alpha = 1
            }
        }
    }
}
