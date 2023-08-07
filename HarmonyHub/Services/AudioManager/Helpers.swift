//
//  Helpers.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 5.08.2023.
//

import Foundation
import UIKit

protocol PreviewPlayable {
    var controllerDelegate : PreviewButtonDelegate? {get}
    var rootViewDelegate : PreviewPlayerViewInterface? {get set}
    var indexPath : IndexPath? {get}
    var ownerTrack : TracksDatum! {get}
    var isPlaying : Bool {get set}
    
    func setupIndexPathAndDelegate(viewDelegate : PreviewPlayerViewInterface,delegate: PreviewButtonDelegate, indexPath: IndexPath)
    func listenToAudioManagerForMusicChanges()
    func playPreviewButtonTapped()
}

protocol PreviewButtonDelegate : AnyObject {
    func handleCellsAudioOutput(output : previewPlayerOutput)
}

enum previewPlayerOutput {
    case stop
    case play(IndexPath)
}



