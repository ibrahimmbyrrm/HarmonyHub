//
//  HomeView.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 31.07.2023.
//

import Foundation
import SnapKit
import UIKit
import Kingfisher
import AVFoundation
var player : AVPlayer!

final class HomeController : BaseViewController<HomeView>{
    //MARK: - Variables
    var audioPlayer : AVAudioPlayer?
    var albums: [AlbumsDatum] = []
    var artists: [ArtistElement] = []
    var tracks : [TracksDatum] = []
    
    var presenter: HomePresenterInterface?
    //MARK: - UIViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        presenter?.handleViewOutput(output: .loadData)
        
    }
    //MARK: - Interface Methods
    func setDelegates() {
        rootView.setCollectionViewDelegates(self)
    }
    
    func setupMediaButtonsActions() {
        rootView.buttonsStackView.buttons.forEach { button in
            button.addTarget(nil, action: #selector(tapped), for: .touchUpInside)
        }
    }
    
    func setupNavigationController() {
        view.backgroundColor = .black
        title = "HarmonyHub"
        self.navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor : UIColor.white,.font : UIFont(name: "Rockwell", size: 44)!]
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @objc func tapped(_ button : MediaCategoryButton) {
        guard let type = button.mediaType else {return}
        rootView.buttonsStackView.changeButtonColors(type: type)
    }
    
}
extension HomeController : HomeViewInterface {
    func handlePresenterOutput(output: HomePresenterToViewOutput) {
        switch output {
        case .albumLoaded(let albums):
            self.albums = albums
        case .artistsLoaded(let artists):
            self.artists = artists
        case .tracksLoaded(let tracks):
            self.tracks = tracks
        }
        rootView.reloadCollectionViewsAsync()
    }
}
extension HomeController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case rootView.topAlbumsCollectionView:
            return albums.count
        case rootView.artistsCollectionView:
            return artists.count
        case rootView.popularTracksCollectionView:
            return tracks.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case rootView.artistsCollectionView:
            return CGSize(width: 80, height: 100)
        case rootView.topAlbumsCollectionView:
            return CGSize(width: 150, height: 180)
        case rootView.popularTracksCollectionView:
            return CGSize(width: 180, height: 250)
        default:
            return CGSize(width: 0, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case rootView.topAlbumsCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "topAlbumCell", for: indexPath) as! TopAlbumCell
            let albumAtIndex = albums[indexPath.row]
            cell.configure(with: albumAtIndex)
            return cell
        case rootView.artistsCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "artistCell", for: indexPath) as! ArtistsCell
            let artistAtIndex = artists[indexPath.row]
            cell.configureData(artist: artistAtIndex)
            return cell
        case rootView.popularTracksCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "popularTracksCell", for: indexPath) as! PopularTracksCell
            let trackAtIndex = tracks[indexPath.row]
            cell.configure(track: trackAtIndex)
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let url = tracks[indexPath.row].preview.convertToUrl() else {return}
        AudioManager.shared.insertQueueAndPlay(url: url)
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        AudioManager.shared.stopAndClearQueue()
        
    }
}

