//
//
// ViewController.swift
//  TinderMechanic
//Copyright (c) 2015 Bianca Binstock. All rights reserved.




import UIKit

class ViewController : UIViewController {
    
    var xFromCenter:CGFloat = 0
//    var label:UILabel!
    // UIImage
    var imageView:UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
//        // Do any additional setup after loading the view, typically from a nib.
//        var label:UILabel = UILabel(frame:
//            CGRectMake(self.view.bounds.width / 2 - 100, self.view.bounds.height / 2 - 50, 200, 100))
//        label.text = "Drag Me"
//        
//        label.textAlignment = NSTextAlignment.Center
//        self.view.addSubview(label)
//        
////        gesture recognizer
//        var gesture = UIPanGestureRecognizer(target: self, action: Selector("wasDragged:"))
//        label.addGestureRecognizer(gesture)
//        label.userInteractionEnabled = true

// with image instead
        imageView = UIImageView(frame: CGRectMake(self.view.bounds.width / 2 - 100, self.view.bounds.height / 2 - 100, 200, 200))
//        default image for our user
        imageView.image = UIImage(named:"mario_360")
//        add a corner radius to our image
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.clipsToBounds = true
        self.view.addSubview(imageView)
        var gesture = UIPanGestureRecognizer(target: self, action: Selector("wasDragged:"))
        imageView.addGestureRecognizer(gesture)
        imageView.userInteractionEnabled = true
     
        
        }
    
    
    func wasDragged(gesture:UIPanGestureRecognizer) {
 
        let translation = gesture.translationInView(self.view)
//        get what has been dragged
        var profile = gesture.view!
        xFromCenter += translation.x
        var scale = min(100 / abs(xFromCenter), 1)
        profile.center = CGPoint(x: profile.center.x + translation.x, y: profile.center.y + translation.y)
//        reset translation
        gesture.setTranslation(CGPointZero, inView: self.view)
//        rotate the label / image
        var rotation:CGAffineTransform = CGAffineTransformMakeRotation(translation.x / 200)
//        stretch the current view
        var stretch:CGAffineTransform = CGAffineTransformScale(rotation, scale, scale)
        //imageView.transform = stretch
  
        // check if chosen or not chosen
        if  profile.center.x < 100 {
            println("not chosen")
//            do nothing
        } else {
            println("chosen")
           // Add to chosen list on parse
    }

        
//        when the gestrue state has ended
        if gesture.state == UIGestureRecognizerState.Ended {
//            set lable/image back
            profile.center = CGPointMake(view.bounds.width / 2, view.bounds.height / 2)
//            undo scale
            scale = max(abs(xFromCenter) / 100, 1)
//            undo any rotation
            rotation = CGAffineTransformMakeRotation(0)
//            stretch the current view
            stretch = CGAffineTransformScale(rotation, scale, scale)
//            set image/label to original size after scaling
            imageView.frame = CGRectMake(self.view.bounds.width / 2 - 100, self.view.bounds.height / 2 - 100, 200, 200)
            
            
        }
}
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


