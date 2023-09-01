//
//  Helpers.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 5.08.2023.
//

import Foundation
import UIKit
import AVFoundation
//MARK: - Implement To Presenter,Interactor and RootView
///This protocols provides communication between layers about only preview plays.It should be implemented on module which has a play preview feature.
protocol PreviewPlayerPresenterClient {
    func transferPreviewPlayableCellToInteractor(delegate: PreviewPlayableCellClient)
    func handleTrackPreviewOutput(output : TrackPreviewOutput)
}
protocol PreviewPlayerInteractorClient {
    var audioService : AudioService {get set}
    func setupAudioServiceDelegate(delegate : PreviewPlayableCellClient)
    func playPreview(url : URL)
    func stopPreview()
}
protocol PreviewPlayerViewClient : AnyObject {
    //When the play preview button tapped druing the other is playing, this function resets all other button to "PLAY" icon again.
    func restartTrackCellPreviewButton(url : URL)
}

//MARK: - Implement To Cell
///This protocol should be implemented on cell which includes play preview feature
protocol PreviewPlayableCellClient : AnyObject, PreviewPlayableClient {
    var rootViewDelegate : PreviewPlayerViewClient? {get set}
    func setupIndexPathAndDelegate(viewDelegate : PreviewPlayerViewClient,delegate: PlayPreviewButtonDelegate, indexPath: IndexPath)
    func listenToAudioManagerForMusicChanges(url : URL)
    func playPreviewButtonTapped()
}

protocol PreviewPlayableClient : AnyObject {
    func playPreviewButtonTapped()
    var controllerDelegate : PlayPreviewButtonDelegate? {get}
    var ownerTrack : TracksDatum! {get}
    var indexPath : IndexPath? {get}
    var isPlaying : Bool {get set}
}
//MARK: - Implement To Controller
///This protocol provides communication when the play button tapped.
protocol PlayPreviewButtonDelegate : AnyObject {
    func handleCellsAudioOutput(output : previewPlayerOutput)
}
//MARK: - Implement to AudioManager
///This protocol provides all needed methods and objects for AudioManager class.It can be used for creating mocks and unit tests.
protocol AudioService {
    func stopAndClearQueue()
    func insertQueueAndPlay(url : URL)
    
    var playerQueue : AVPlayer {get set}
    var currentTrack : URL? {get set}
    var previewPlayerDelegate : PreviewPlayableCellClient? {get set}
}





