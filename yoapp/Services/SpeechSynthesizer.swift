//
//  SpeechSynthesizer.swift
//  DARVis
//
//  Created by Mirzhan Gumarov on 6/14/18.
//  Copyright © 2018 DAR Ecosystem. All rights reserved.
//

import Foundation
import AVFoundation

class SpeechSynthesizer {
    static func speak(_ text: String?) {
        guard let unwrappedText = text else { return }
        
        let session = AVAudioSession.sharedInstance()
        
        do {
            try session.setCategory(AVAudioSessionCategoryPlayback, with: [AVAudioSessionCategoryOptions.mixWithOthers])
            try session.setActive(true)
        } catch(let error) {
            print("----------------------------- \(error.localizedDescription)")
        }
        
        let utterance = AVSpeechUtterance(string: unwrappedText)
        let voiceLanguage = getVoiceLanguageIdentifier(of: unwrappedText)
        utterance.voice = AVSpeechSynthesisVoice(language: voiceLanguage)
        
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
    }
    
    private static func getVoiceLanguageIdentifier(of text: String) -> String {
        if text.isLatin {
            return "en-US"
        } else {
            return "ru-RU"
        }
    }
}

extension String {
    var isLatin: Bool {
        let upperLatin: String = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let lowerLatin: String = upperLatin.lowercased()
        
        for character in self.map({ String($0) }) {
            if upperLatin.contains(character) && lowerLatin.contains(character) {
                return true
            }
        }
        
        return false
    }
}
