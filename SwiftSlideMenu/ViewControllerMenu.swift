//
//  ViewControllerMenu.swift
//  SwiftSlideMenu
//
//  Created by saumya on 16/05/16.
//  Copyright © 2016 saumya. All rights reserved.
//

import UIKit

class ViewControllerMenu : UIViewController {
    // 1
    var interactor:Interactor? = nil
    // 2
    @IBAction func handleGesture(sender: UIPanGestureRecognizer) {
        // 3
        let translation = sender.translationInView(view)
        // 4
        let progress = MenuHelper.calculateProgress(
            translation,
            viewBounds: view.bounds,
            direction: .Left
        )
        // 5
        MenuHelper.mapGestureStateToInteractor(
            sender.state,
            progress: progress,
            interactor: interactor){
                // 6
                self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    @IBAction func closeMenu(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
