//
//  CustomPresentationAnimationController.swift
//  CustomPresentation
//
//  Created by Jeff Gayle on 9/13/14.
//  Copyright (c) 2014 Jeff Gayle. All rights reserved.
//

import Foundation
import UIKit

class CustomPresentationAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    let isPresenting : Bool
    let duration : NSTimeInterval = 0.5
    
    init (isPresenting: Bool) {
        self.isPresenting = isPresenting
        super.init()
    }
    
    //UIViewControllerAnimatedTransitioning methods
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return self.duration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        if isPresenting {
            self.animatePresentationWithTransitionContext(transitionContext)
        } else {
            animateDismissalWithTransitionContext(transitionContext)
        }
    }
    
    //Helper Methods
    
    func animatePresentationWithTransitionContext(transitionContext: UIViewControllerContextTransitioning) {
        
        let presentedController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey!)
        let presentedControllerView = transitionContext.viewForKey(UITransitionContextToViewKey!)
        let containerView = transitionContext.containerView()
        
        //Position presented view off top of container view
        presentedControllerView!.frame = transitionContext.finalFrameForViewController(presentedController!)
        presentedControllerView!.center.y -= containerView.bounds.size.height
        
        containerView.addSubview(presentedControllerView!)
        
        //Animate the Presented View to final position
        
        UIView.animateWithDuration(self.duration, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: UIViewAnimationOptions.AllowUserInteraction, animations: { () -> Void in
            presentedControllerView!.center.y += containerView.bounds.size.height
        }) { (success) -> Void in
            transitionContext.completeTransition(true)
        }
        
        
        
    }
    
    func animateDismissalWithTransitionContext(transitionContext: UIViewControllerContextTransitioning) {
        
        let presentedControllerView = transitionContext.viewForKey(UITransitionContextFromViewKey!)
        let containerView = transitionContext.containerView()
        
        //Animate presented view off bottom of screen
        UIView.animateWithDuration(self.duration, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: UIViewAnimationOptions.AllowUserInteraction, animations: { () -> Void in
            presentedControllerView!.center.y += containerView.bounds.size.height
        }) { (success) -> Void in
            transitionContext.completeTransition(true)
        }
        
        
    }
}