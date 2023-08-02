//
//  AudioManager.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 2.08.2023.
//

import Foundation
import AVFoundation

class AudioManager {
    static let shared = AudioManager()
    private init() {}
    
    lazy var playerQueue : AVQueuePlayer = {
        return AVQueuePlayer()
    }()
    
    func insertQueueAndPlay(url : URL) {
        let playerItem = AVPlayerItem.init(url: url)
        self.playerQueue.insert(playerItem, after: nil)
        self.playerQueue.play()
    }
    
    func stopAndClearQueue() {
        self.playerQueue.removeAllItems()
        self.playerQueue.pause()
    }
}
