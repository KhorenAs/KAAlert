//
//  WTBlurView.swift
//  WtiApp
//
//  Created by Khoren on 11/21/18.
//  Copyright © 2018 Wealth Tech. All rights reserved.
//

import UIKit

@IBDesignable class KABlurView: UIView {

    private var blurView: UIVisualEffectView?
    private var blurEffect: UIBlurEffect?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }

    @IBInspectable var blurRadius: CGFloat = 10 {
        didSet {
            self.setBlurValue(value: blurRadius, forKey: "blurRadius")
        }
    }

    @IBInspectable var colorTint: UIColor = UIColor.clear {
        didSet {
            self.setBlurValue(value: colorTint, forKey: "colorTint")
        }
    }

    @IBInspectable var colorTintAlpha: CGFloat = 0.3 {
        didSet {
            self.setBlurValue(value: colorTintAlpha, forKey: "colorTintAlpha")
        }
    }

    @IBInspectable var saturationDeltaFactor: CGFloat = 1 {
        didSet {
            self.setBlurValue(value: saturationDeltaFactor, forKey: "saturationDeltaFactor")
        }
    }
    
    private func setup()  {
        self.backgroundColor = UIColor.clear
        self.addBlurView()
        self.setBlurValue(value: blurRadius, forKey: "blurRadius")
        self.setBlurValue(value: colorTint, forKey: "colorTint")
        self.setBlurValue(value: colorTintAlpha, forKey: "colorTintAlpha")
    }
    
    private func addBlurView()  {
        if self.blurView == nil {
            self.blurEffect = (NSClassFromString("_UICustomBlurEffect") as! UIBlurEffect.Type).init()
            self.blurView = UIVisualEffectView.init(effect: blurEffect)
            if let blurView = self.blurView {
                blurView.frame = self.bounds;
                blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                self.addSubview(blurView)
                self.sendSubviewToBack(blurView)
            }
        }
    }
    
    private func setBlurValue<T>(value: T?, forKey key: String) {
        self.blurEffect?.setValue(value, forKey: key)
        self.blurView?.effect = self.blurEffect
    }

}
