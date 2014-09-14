//
//  CustomPresentationController.swift
//  CustomPresentation
//
//  Created by Jeff Gayle on 9/12/14.
//  Copyright (c) 2014 Jeff Gayle. All rights reserved.
//

import UIKit

class CustomPresentationController: UIPresentationController {
   
     var dimmingView: UIView {
        let view = UIView(frame: self.containerView!.bounds)
        view.backgroundColor = UIColor.redColor()
        view.alpha = 0.5
        return view
    }
    
    override func presentationTransitionWillBegin() {
        //Add dimming view and presented view to the hierarchy
        self.dimmingView.frame = self.containerView.bounds
        self.containerView.addSubview(self.dimmingView)
        self.containerView.addSubview(self.presentedView())
        
        //Fade in the dimming view alongside the transition
        let transitionCoordinator = self.presentingViewController.transitionCoordinator()
        transitionCoordinator?.animateAlongsideTransition({ (context:UIViewControllerTransitionCoordinatorContext!) -> Void in
            
            self.dimmingView.alpha = 1.0
            
        }, completion: nil)
    }
    
    override func presentationTransitionDidEnd(completed: Bool) {
        //If presentation didn't complete, remove the dimming view
        if !completed {
            self.dimmingView.removeFromSuperview()
        }
    }
    
    override func dismissalTransitionWillBegin() {
        //Fade out the dimming view alongside the transition
        let transitionCoordinator = self.presentingViewController.transitionCoordinator()
        transitionCoordinator?.animateAlongsideTransition({ (context: UIViewControllerTransitionCoordinatorContext!) -> Void in
            
            self.dimmingView.alpha = 0.0
            
        }, completion: nil)
    }
    
    override func dismissalTransitionDidEnd(completed: Bool) {
        if completed {
            self.dimmingView.removeFromSuperview()
        }
    }
    
    override func frameOfPresentedViewInContainerView() -> CGRect {
        var frame = self.containerView.bounds
        frame = CGRectInset(frame, 50.0, 50.0)
        return frame
    }
    
    //MARK: UIContentContainer protocol methods
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        
        coordinator.animateAlongsideTransition({ (context: UIViewControllerTransitionCoordinatorContext!) -> Void in
            self.dimmingView.frame = self.containerView.bounds
        }, completion: nil)
    }
    
}
