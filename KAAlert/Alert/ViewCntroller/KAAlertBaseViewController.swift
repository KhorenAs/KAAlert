//
//  WTAlertViewController.swift
//  WtiApp
//
//  Created by Khoren on 11/20/18.
//  Copyright © 2018 Wealth Tech. All rights reserved.
//

import UIKit

class KAAlertBaseViewController: UIViewController, KATransitioningAnimatorDelegate {
    
    var transitioning: KATransitioningAnimator = KATransitioningAnimator()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }

    // MARK: Overriders

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.setup()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { (ontext) in
            self.transitioning.updateSize(size: size)
        }, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        KASoundEffect.playSound(type: .changed)
    }

    //MARK: Public Methods

    func endFrameViewController(transitioningAnimator: KATransitioningAnimator, toRect: CGRect) -> CGRect? {
        return nil
    }
    
    func endTransitionSize(transitioningAnimator: KATransitioningAnimator, toSize: CGSize) -> CGSize? {
        return nil
    }
    
    func startFrameViewController(transitioningAnimator: KATransitioningAnimator, toRect: CGRect) -> CGRect? {
        return nil
    }
    
    func startTransitionSize(transitioningAnimator: KATransitioningAnimator, toRect: CGSize) -> CGSize? {
        return nil
    }
    
    func backgroundView(transitioningAnimator: KATransitioningAnimator) -> UIView? {
        return nil
    }
    
    func shouldSelectBackgroundView(transitioningAnimator: KATransitioningAnimator) -> Bool {
        return true
    }
    
    func didSelectBackgroundView(transitioningAnimator: KATransitioningAnimator, tapGestureRecognizer: UITapGestureRecognizer) {
         self.dismiss(animated: true, completion: nil)
    }
    
    func willAnimation(transitioningAnimator: KATransitioningAnimator) {}
    func animated(transitioningAnimator: KATransitioningAnimator) {}
    func didEndAnimation(transitioningAnimator: KATransitioningAnimator){}


    //MARK: Private Methods

    private func setup()  {
        self.transitioning.deleagte = self
        if let nav = self.navigationController {
            self.transitioning.setupTransitioning(in: nav)
        } else {
            self.transitioning.setupTransitioning(in: self)
        }
    }
    
}

