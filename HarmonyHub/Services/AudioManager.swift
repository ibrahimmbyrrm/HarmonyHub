//
//  AudioManager.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 2.08.2023.
//

import Foundation
import AVFoundation

var player : AVPlayer?

class AudioManager {

    
    func playSound(url : URL) {
        print("play sound called")
        do{
            print("şlmfdlmşds")
            player = try! AVPlayer(url: url)
            player!.volume = 12
            player!.play()
        }catch {
            print("yine olmadı amj")
        }
        
    }
}
