//
//  Helpers.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 5.08.2023.
//

import Foundation
import UIKit

//MARK: - Implement To Presenter,Interactor and RootView
///This protocols provides communication between layers about only preview plays.It should be implemented on module which has a play preview feature.
protocol PreviewPresenter {
    func implementPreviewPlayableDelegate(delegate: PreviewPlayable)
    func handleTrackPreviewOutput(output : TrackPreviewOutput)
}
protocol PreviewInteractor {
    var audioService : AudioService {get set}
    func setupAudioServiceDelegate(delegate : PreviewPlayable)
    func playPreview(url : URL)
    func stopPreview()
}
protocol PreviewPlayerViewInterface : AnyObject {
    //When the play preview button tapped druing the other is playing, this function resets all other button to "PLAY" icon again.
    func restartTrackCellPreviewButton(url : URL)
}

//MARK: - Implement To Cell
///This protocol should be implemented on cell which includes play preview feature
protocol PreviewPlayable : AnyObject {
    var controllerDelegate : PreviewButtonDelegate? {get}
    var rootViewDelegate : PreviewPlayerViewInterface? {get set}
    var indexPath : IndexPath? {get}
    var ownerTrack : TracksDatum! {get}
    var isPlaying : Bool {get set}
    
    func setupIndexPathAndDelegate(viewDelegate : PreviewPlayerViewInterface,delegate: PreviewButtonDelegate, indexPath: IndexPath)
    func listenToAudioManagerForMusicChanges(url : URL)
    func playPreviewButtonTapped()
}
//MARK: - Implement To Controller
///This protocol provides communication when the play button tapped.
protocol PreviewButtonDelegate : AnyObject {
    func handleCellsAudioOutput(output : previewPlayerOutput)
}
//MARK: - Outputs
enum previewPlayerOutput {
    case stop
    case play(IndexPath)
}



