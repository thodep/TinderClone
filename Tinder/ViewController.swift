//
//  ViewController.swift
//  Tinder
//
//  Created by tho dang on 2015-05-25.
//  Copyright (c) 2015 ThoDang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var xFromCenter:CGFloat = 0
    // when the view
    // UIImage
    var imageView : UIImageView!
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // set the image to the appropriate x and y position
        imageView  = UIImageView(frame:CGRectMake(self.view.bounds.width / 2 - 100, self.view.bounds.height / 2 - 100, 200, 200));
        // default image to be used TODO: use image from device or facebook
        imageView.image = UIImage(named:"user.png")
        // add corner radius styling to image
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        // need to clip to bounds or it won't work
        imageView.clipsToBounds = true
        self.view.addSubview(imageView)
        // add gesture recognizer with image to be called
        var gesture = UIPanGestureRecognizer(target: self, action: Selector("wasDragged:"))
        // assign gesture to image view
        imageView.addGestureRecognizer(gesture)
        // enable gestures on the imageView
        imageView.userInteractionEnabled = true
    }
    func wasDragged(gesture:UIPanGestureRecognizer) {
        
        let translation = gesture.translationInView(self.view)
        // get was has been dragged
        var profile = gesture.view!
        xFromCenter += translation.x
        var scale = min( 100 / abs(xFromCenter), 1)
        profile.center = CGPoint(x: profile.center.x + translation.x, y: profile.center.y + translation.y)
        // reset translation
        gesture.setTranslation(CGPointZero, inView: self.view)
        //rotate label
        var rotation:CGAffineTransform = CGAffineTransformMakeRotation(translation.x / 200)
        //streth the current view , to make the image zoom in to you
        var stretch:CGAffineTransform = CGAffineTransformScale(rotation, scale, scale)
        //imageView.transform = stretch
        // check if chosen or not chosen
        if profile.center.x <  100 {
            println("not chose")
            // do nothing
        } else {
            println("chosen")
            // Add to chosen list on parse
        }
        // when the gesture state has ended, when a picture is chosen
        if gesture.state == UIGestureRecognizerState.Ended {
            // set the label back
            profile.center = CGPointMake(view.bounds.width / 2, view.bounds.height / 2)
            // undo scale
            scale = max(abs(xFromCenter) / 100, 1)
            // undo rotation and stretch
            rotation = CGAffineTransformMakeRotation(0)
            // stretch the current view
            stretch = CGAffineTransformScale(rotation, scale, scale)
            // set image to original size after scaling
            imageView.frame = CGRectMake(self.view.bounds.width / 2 - 100, self.view.bounds.height / 2 - 100, 200, 200)
        }
        // TODO: load next image
        
        func nopeButon (){
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

