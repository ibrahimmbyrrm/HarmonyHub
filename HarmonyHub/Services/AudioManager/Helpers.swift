//
//  Helpers.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 5.08.2023.
//

import Foundation
import UIKit

protocol PreviewPlayableCell {
    var delegate : PreviewButtonDelegate? {get}
    var indexPath : IndexPath? {get}
    var ownerTrack : TracksDatum! {get}
    var isPlaying : Bool {get set}
    
    func listenToAudioManagerForMusicChanges()
    func playPreviewButtonTapped()
    func setupIndexPathAndDelegate(delegate : PreviewButtonDelegate, indexPath : IndexPath)
}

protocol PreviewButtonDelegate : AnyObject {
    func handleCellsAudioOutput(output : previewPlayerOutput)
}

enum previewPlayerOutput {
    case stop
    case play(IndexPath)
}



