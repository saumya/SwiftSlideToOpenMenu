//
//  ViewControllerHome.swift
//  SwiftSlideMenu
//
//  Created by saumya on 16/05/16.
//  Copyright © 2016 saumya. All rights reserved.
//


import UIKit

class ViewControllerHome: UIViewController {
    // 1
    let interactor = Interactor()
    
    @IBAction func openMenu(sender: AnyObject) {
        performSegueWithIdentifier("openMenu", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destinationViewController = segue.destinationViewController as? ViewControllerMenu {
            destinationViewController.transitioningDelegate = self
            // 2
            destinationViewController.interactor = interactor
        }
    }
    
    @IBAction func edgePanGesture(sender: UIScreenEdgePanGestureRecognizer) {
        let translation = sender.translationInView(view)
        
        let progress = MenuHelper.calculateProgress(translation, viewBounds: view.bounds, direction: .Right)
        
        MenuHelper.mapGestureStateToInteractor(
            sender.state,
            progress: progress,
            interactor: interactor){
                self.performSegueWithIdentifier("openMenu", sender: nil)
        }
    }
}

extension ViewControllerHome: UIViewControllerTransitioningDelegate {
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentMenuAnimator()
    }
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissMenuAnimator()
    }
    // 3
    func interactionControllerForDismissal(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactor.hasStarted ? interactor : nil
    }
    
    func interactionControllerForPresentation(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactor.hasStarted ? interactor : nil
    }
}
