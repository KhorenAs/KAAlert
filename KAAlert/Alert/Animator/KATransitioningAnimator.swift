//
//  WTTransitioningAnimator.swift
//  WtiApp
//
//  Created by Khoren on 11/20/18.
//  Copyright © 2018 Wealth Tech. All rights reserved.
//

import UIKit


class KATransitioningAnimator: NSObject {
    
    struct Settings {
        var duration: TimeInterval = 0.4
        var delay: TimeInterval = 0.1
        var options: UIView.AnimationOptions = .curveEaseInOut
        var damping: CGFloat = 0.8
        var velocity: CGFloat = 0.8
    }
   
    private let blurEffectViewTag: Int = 1021
    private weak var backgroundView: UIView?
    private(set) var keyboardHeight: CGFloat = 0
    private(set) weak var fromViewController: UIViewController?
    private(set) weak var toViewController: UIViewController?
    private(set) var isPresent: Bool = true
   
    weak var deleagte: KATransitioningAnimatorDelegate?
    var animatorSettings: Settings = Settings()
    var transitionSizeScale:CGFloat = 0.5
    
    override init() {
        super.init()
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    //MARK: public
    
    func setupTransitioning(in viewController: UIViewController)  {
        viewController.modalPresentationStyle = .custom;
        viewController.transitioningDelegate = self;
    }
    
    func updateSize(size: CGSize) {
        self.updateFrame(frame: CGRect(origin: CGPoint.zero, size: size))
    }
    
    func updateFrame(frame: CGRect) {
        let endFrame = self.endFrameForPresentVC(frame: frame)
        self.toViewController?.view.frame = endFrame
        self.toViewController?.view.layoutIfNeeded()
    }
    
    //MARK: private
    
    @objc private func didSelectBackgroundView(tapGesture: UITapGestureRecognizer) {
        self.deleagte?.didSelectBackgroundView(transitioningAnimator: self, tapGestureRecognizer: tapGesture)
    }
    
    //MARK: NotificationCenter
    
    @objc private func adjustForKeyboard(notification: Notification) {
        guard let userInfo = notification.userInfo else {
            return
        }
        let keyboardScreenEndFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        if notification.name == UIResponder.keyboardWillHideNotification {
            self.keyboardHeight = 0
        } else {
            self.keyboardHeight = keyboardScreenEndFrame.height
        }
        self.updateSize(size: UIScreen.main.bounds.size)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}


extension KATransitioningAnimator: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.isPresent = true
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.isPresent = false
        return self
    }

}

extension KATransitioningAnimator: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animatorSettings.duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if self.isPresent {
            self.presentCntroller(transitionContext: transitionContext)
        } else {
            self.dismissCntroller(transitionContext: transitionContext)
        }
    }
    
    //MARK: Present Transition
    
    func preparePresentCntroller(transitionContext: UIViewControllerContextTransitioning) {
        self.fromViewController = transitionContext.viewController(forKey: .from)
        self.toViewController = transitionContext.viewController(forKey: .to)
        guard let toViewController = self.toViewController, let toView = transitionContext.view(forKey: .to) else {
            return
        }
        let containerView: UIView = transitionContext.containerView
        let startFrame: CGRect = self.startFrameForPresentVC(frame: containerView.bounds)
        let backgroundView = self.createBlurEffectView(frame: containerView.bounds)
        backgroundView.alpha = 0
        toViewController.view.setNeedsUpdateConstraints()
        containerView.addSubview(backgroundView)
        containerView.addSubview(toView)
        toView.frame = startFrame
        containerView.layoutIfNeeded()
        self.deleagte?.willAnimation(transitioningAnimator: self)
    }
    
    private func presentCntroller(transitionContext: UIViewControllerContextTransitioning) {
        self.preparePresentCntroller(transitionContext: transitionContext)
        guard let toViewController = self.toViewController else {
            return
        }
        let containerView: UIView = transitionContext.containerView
        let endFrame: CGRect = self.endFrameForPresentVC(frame: containerView.bounds)
        UIView.animate(withDuration: self.animatorSettings.duration, delay: self.animatorSettings.delay, usingSpringWithDamping: self.animatorSettings.damping, initialSpringVelocity: self.animatorSettings.velocity, options: self.animatorSettings.options, animations: {
            self.backgroundView?.alpha = 0.16
            toViewController.view.frame = endFrame;
            containerView.layoutIfNeeded()
            self.deleagte?.animated(transitioningAnimator: self)
        }) { (_) in
            transitionContext.completeTransition(true)
            containerView.layoutIfNeeded()
            if  let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from), fromView.superview == nil {
                containerView.insertSubview(fromView, at: 0)
            }
            self.deleagte?.didEndAnimation(transitioningAnimator: self)
        }
    }
    
    //MARK: Dismiss Transition
    
    private func dismissCntroller(transitionContext: UIViewControllerContextTransitioning) {
        self.fromViewController = transitionContext.viewController(forKey: .to)
        self.toViewController = transitionContext.viewController(forKey: .from)
        guard let toViewController = self.toViewController else {
            return
        }
        let containerView: UIView = transitionContext.containerView
        let endFrame: CGRect = self.startFrameForPresentVC(frame: containerView.bounds)
        self.deleagte?.willAnimation(transitioningAnimator: self)
        containerView.layoutIfNeeded()
        
        UIView.animate(withDuration: self.animatorSettings.duration, delay: self.animatorSettings.delay, usingSpringWithDamping: self.animatorSettings.damping, initialSpringVelocity: self.animatorSettings.velocity, options: self.animatorSettings.options, animations: {
            self.backgroundView?.alpha = 0
            toViewController.view.frame = endFrame;
            containerView.layoutIfNeeded()
            self.deleagte?.animated(transitioningAnimator: self)
        }) { (_) in
            self.backgroundView?.removeFromSuperview()
            containerView.layoutIfNeeded()
            self.deleagte?.didEndAnimation(transitioningAnimator: self)
            transitionContext.completeTransition(true)
        }
    }
    
    //MARK: Helper Transition
    
    private func startSizeForPresentVC(size: CGSize) -> CGSize {
        if let newSize = self.deleagte?.startTransitionSize(transitioningAnimator: self, toRect: size) {
            return newSize
        }
        return CGSize.zero
    }
    
    private func startFrameForPresentVC(frame: CGRect) -> CGRect {
        if let newFrame = self.deleagte?.startFrameViewController(transitioningAnimator: self, toRect: frame) {
            return newFrame
        }
        var resultFrame: CGRect = .zero
        resultFrame.size = self.startSizeForPresentVC(size: frame.size)
        let height = frame.size.height - self.keyboardHeight
        resultFrame.origin.x = (frame.size.width - resultFrame.size.width)/2
        resultFrame.origin.y = (height - resultFrame.size.height)/2
        return resultFrame
    }
    
    private func endSizeForPresentVC(size: CGSize) -> CGSize {
        if let newSize = self.deleagte?.endTransitionSize(transitioningAnimator: self, toSize: size) {
            return newSize
        }
        let scale: CGFloat = self.transitionSizeScale <= 0 ? 0 : self.transitionSizeScale
        let resultSize: CGSize = CGSize(width: size.width * scale, height: (size.height - self.keyboardHeight) * scale)
        return resultSize
    }
    
    private func endFrameForPresentVC(frame: CGRect) -> CGRect {
        if let newFrame = self.deleagte?.endFrameViewController(transitioningAnimator: self, toRect: frame) {
            return newFrame
        }
        var resultFrame: CGRect = .zero
        resultFrame.size = self.endSizeForPresentVC(size: frame.size)
        let height = frame.size.height - self.keyboardHeight
        resultFrame.origin.x = (frame.size.width - resultFrame.size.width)/2
        resultFrame.origin.y = (height - resultFrame.size.height)/2
        return resultFrame
    }
    
    private func createBlurEffectView(frame: CGRect) -> UIView {
        let resultBackgroundView: UIView!
        if let backgroundView = self.deleagte?.backgroundView(transitioningAnimator: self) {
           resultBackgroundView = backgroundView
        } else {
            let blurView = KABlurView(frame: frame)
            blurView.colorTint = UIColor.black
            blurView.colorTintAlpha = 1
            blurView.blurRadius = 50
            blurView.saturationDeltaFactor = 0.1
            resultBackgroundView = blurView
        }
        resultBackgroundView.frame = frame
        resultBackgroundView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        resultBackgroundView.tag = self.blurEffectViewTag
        
        if self.deleagte?.shouldSelectBackgroundView(transitioningAnimator: self) ?? false {
            let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(didSelectBackgroundView(tapGesture:)))
            resultBackgroundView.addGestureRecognizer(tapGesture)
        }
        self.backgroundView = resultBackgroundView
        return resultBackgroundView
    }
    
    
    
}
