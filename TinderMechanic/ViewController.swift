//
//
// ViewController.swift
//  TinderMechanic
//Copyright (c) 2015 Bianca Binstock. All rights reserved.




import UIKit

class ViewController : UIViewController, FBSDKLoginButtonDelegate {
    
    var xFromCenter:CGFloat = 0
//    var label:UILabel!
    // UIImage
    var imageView:UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

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
        
//        facebook login
        
        
        if (FBSDKAccessToken.currentAccessToken() != nil)
        {
            // User is already logged in, do work such as go to next view controller.
        }
        else
        {
            let loginView : FBSDKLoginButton = FBSDKLoginButton()
            self.view.addSubview(loginView)
            loginView.center = self.view.center
            loginView.readPermissions = ["public_profile", "email", "user_friends"]
            loginView.delegate = self
        }
        
    }
    

    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        println("User Logged In")
        
        if ((error) != nil)
        {
            // Process error
        }
        else if result.isCancelled {
            // Handle cancellations
        }
        else {
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            if result.grantedPermissions.contains("email")
            {
                // Do work
            }
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        println("User Logged Out")
    }
    
    func returnUserData()
    {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                // Process error
                println("Error: \(error)")
            }
            else
            {
                println("fetched user: \(result)")
                let userName : NSString = result.valueForKey("name") as! NSString
                println("User Name is: \(userName)")
                let userEmail : NSString = result.valueForKey("email") as! NSString
                println("User Email is: \(userEmail)")
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


