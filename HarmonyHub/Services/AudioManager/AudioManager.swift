//
//  AudioManager.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 2.08.2023.
//

import Foundation
import AVFoundation

protocol AudioService {
    func stopAndClearQueue()
    func insertQueueAndPlay(url : URL)
    
    var playerQueue : AVPlayer {get set}
    var currentTrack : URL? {get set}
    var previewPlayerDelegate : PreviewPlayable? {get set}
}

class AudioManager {
    
    lazy var playerQueue : AVPlayer = AVPlayer()
    lazy var currentTrack : URL? = nil
    weak var previewPlayerDelegate : PreviewPlayable?
    
}
extension AudioManager : AudioService {

    func stopAndClearQueue() {
        currentTrack = nil
        self.playerQueue.replaceCurrentItem(with: nil)
        self.playerQueue.pause()
    }
    
    func insertQueueAndPlay(url : URL) {
        if currentTrack != nil {
            previewPlayerDelegate?.listenToAudioManagerForMusicChanges(url: url)
            stopAndClearQueue()
        }
        self.currentTrack = url
        let playerItem = AVPlayerItem.init(url: url)
        self.playerQueue.replaceCurrentItem(with: playerItem)
        self.playerQueue.play()
        DispatchQueue.main.asyncAfter(deadline: .now() + 30) {
            self.previewPlayerDelegate?.listenToAudioManagerForMusicChanges(url: "https://samplelib.com/lib/preview/mp3/sample-12s.mp3".convertToUrl()!)
        }
        
    }
}
