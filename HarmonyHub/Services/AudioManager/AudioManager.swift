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
    func bind(_ listener : @escaping (URL)->Void)
    
    var playerQueue : AVPlayer {get set}
    var currentTrack : URL? {get set}
    var listener : ((URL) -> Void)? {get set}
}

class AudioManager {
    
    static let shared = AudioManager()
    private init() {}
    
    lazy var playerQueue : AVPlayer = AVPlayer()
    lazy var currentTrack : URL? = nil
    
    var listener : ((URL) -> Void)?
    func bind(_ listener : @escaping (URL)->Void) {
        self.listener = listener
    }
    
    
}
extension AudioManager : AudioService {
    
    func stopAndClearQueue() {
        currentTrack = nil
        self.playerQueue.replaceCurrentItem(with: nil)
        self.playerQueue.pause()
    }
    
    func insertQueueAndPlay(url : URL) {
        if currentTrack != nil {
            listener!(url)
            stopAndClearQueue()
        }
        self.currentTrack = url
        let playerItem = AVPlayerItem.init(url: url)
        self.playerQueue.replaceCurrentItem(with: playerItem)
        self.playerQueue.play()
        DispatchQueue.main.asyncAfter(deadline: .now() + 30) {
            guard let listener = self.listener else {return}
            listener("https://samplelib.com/lib/preview/mp3/sample-12s.mp3".convertToUrl()!)
        }
        
    }
}
