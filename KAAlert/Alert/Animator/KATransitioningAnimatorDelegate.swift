//
//  ITransitioningAnimatorDelegate.swift
//  WtiApp
//
//  Created by Khoren on 11/25/18.
//  Copyright © 2018 Wealth Tech. All rights reserved.
//

import Foundation
import UIKit

protocol KATransitioningAnimatorDelegate: class {
    
    /**
     Set ViewController result rect
     
     if result value is nill method get main rect with transition Size Scale and set center hear
     
     - parameters:
     - toRect: The new frame for the container’s view.
     - transitioningAnimator: KATransitioningAnimator.
     
     @paran toRect The new frame for the container’s view.
     */
    
    func endFrameViewController(transitioningAnimator: KATransitioningAnimator, toRect: CGRect) -> CGRect?
    
    /**
     Set ViewController end result size with center main frame
     
     Working when endFrameViewController: not implemented
     
     if result value is nill method get main rect with transition Size Scale and set center hear
     
     @paran toSize The new size for the container’s view.
     
     - parameters:
     - toSize: The new size for the container’s view.
     - transitioningAnimator: KATransitioningAnimator.
     */
    func endTransitionSize(transitioningAnimator: KATransitioningAnimator, toSize: CGSize) -> CGSize?
    
    /**
     Set ViewController result rect will present and end dismis
     
     if result value is nill method get main rect
     
     - parameters:
     - toRect: The new frame for the container’s view.
     - transitioningAnimator: KATransitioningAnimator.
     
     @paran toRect
     */
    
    func startFrameViewController(transitioningAnimator: KATransitioningAnimator, toRect: CGRect) -> CGRect?
    
    
    /**
     Set ViewController frame will present and end dismis
     
     Working when startFrameViewController: not implemented
     
     if result value is nill method get main rect with transition Size Scale and set center hear
     
     - parameters:
     - toSize: The new size for the container’s view.
     - transitioningAnimator: KATransitioningAnimator.
     */
    
    func startTransitionSize(transitioningAnimator: KATransitioningAnimator, toRect: CGSize) -> CGSize?
    
    
    /**
     Set in the background
     
     if result value = nil use default
     
     - parameters:
     - transitioningAnimator: KATransitioningAnimator.
     
     */
    
    func backgroundView(transitioningAnimator: KATransitioningAnimator) -> UIView?
    
    
    /**
     Should select background View
     
     - parameters:
     - transitioningAnimator: KATransitioningAnimator.
     */
    
    func shouldSelectBackgroundView(transitioningAnimator: KATransitioningAnimator) -> Bool
    
    /**
     Select background View
     
     - parameters:
     - transitioningAnimator: KATransitioningAnimator.
     - tapGestureRecognizer: UITapGestureRecognizer.
     */
    
    func didSelectBackgroundView(transitioningAnimator: KATransitioningAnimator, tapGestureRecognizer: UITapGestureRecognizer)
    
    /**
     Will Animation function
     
     - parameters:
     - transitioningAnimator: KATransitioningAnimator.
     */
    
    func willAnimation(transitioningAnimator: KATransitioningAnimator)
    
    /**
    Animation function
     
     - parameters:
     - transitioningAnimator: KATransitioningAnimator.
     */
    
    func animated(transitioningAnimator: KATransitioningAnimator)
    
    /**
     End Animation function
     
     - parameters:
     - transitioningAnimator: KATransitioningAnimator.
     */
    
    func didEndAnimation(transitioningAnimator: KATransitioningAnimator)
    
}

