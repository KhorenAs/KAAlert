//
//  KASoundEffect.swift
//  KAAlert
//
//  Created by MNMKhoren on 4/16/19.
//  Copyright © 2019 Asatryasn. All rights reserved.
//

import UIKit
import AudioToolbox

class KASoundEffect {
    
    enum SoundType: Int {
        case light
        case medium
        case heavy
        case changed
        case peek
        case pop
        case cancelled
        case tryAgain
        case failed
    }
    
    //MARK: public
    
    class func playSound(type: SoundType) {
        if type.rawValue < 3 {
            self.playSoundFeedback(type: type)
        }else if type.rawValue == 3 {
            self.playSoundChanged()
        }else {
            self.playAudioServices(type: type)
        }
    }
    
    //MARK: private
    
    private class func playSoundFeedback(type: SoundType)  {
        guard self.canUseUISound(), let style = UIImpactFeedbackGenerator.FeedbackStyle(rawValue: type.rawValue)  else {
            return self.playAudioServices(type: .peek)
        }
        let feedbackGenerator = UIImpactFeedbackGenerator(style: style)
        feedbackGenerator.prepare()
        feedbackGenerator.impactOccurred()
        
    }

    private class func playSoundChanged() {
        guard self.canUseUISound() else {
            return self.playAudioServices(type: .peek)
        }
        let feedbackGenerator = UISelectionFeedbackGenerator()
        feedbackGenerator.prepare()
        feedbackGenerator.selectionChanged()
    }
    
    private class func playAudioServices(type: SoundType) {
        switch type {
        case .peek:
            self.playAudioServices(id: 1519)
        case .pop:
            self.playAudioServices(id: 1520)
        case .cancelled:
            self.playAudioServices(id: 1521)
        case .tryAgain:
            self.playAudioServices(id: 1102)
        case .failed:
            self.playAudioServices(id: 1107)
        default:
            break
        }
    }
    
    private class func playAudioServices(id: Int) {
        AudioServicesPlaySystemSound(SystemSoundID(id))
    }
    
    private class func canUseUISound() -> Bool {
        let width = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)
        return width > 320 && UIDevice.current.userInterfaceIdiom == .phone
    }
 
}
