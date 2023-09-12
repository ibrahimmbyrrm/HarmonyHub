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

final class HomeController : BaseViewController<HomeView>{
    //MARK: - Variables
    var albums: [AlbumsDatum] = []
    var artists: [ArtistElement] = []
    var tracks : [TracksDatum] = []
    
    var presenter: HomePresenterInterface?
    //MARK: - UIViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        presenter?.handleTrackPreviewOutput(output: .stopPreview)
    }
    //MARK: - Interface Methods
    func setDelegates() {
        rootView.setCollectionViewDelegates(self)
    }
    
    func getData() {
        presenter?.handleViewOutput(output: .loadData)
    }
    
    func setupMediaButtonsActions() {
        rootView.buttonsStackView.buttons.forEach( {$0.addTarget(nil, action: #selector(tapped), for: .touchUpInside) })
    }
    
    func setupNavigationController() {
        view.backgroundColor = .black
        title = PageTitles.homeTitle
        self.navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor : UIColor.white,.font : UIFont(name: FontNames.rockwell, size: 44)!]
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @objc func tapped(_ button : MediaCategoryButton) {
        guard let type = button.mediaType else {return}
        rootView.buttonsStackView.changeButtonColors(type: type)
    }
    
}
extension HomeController : HomeViewInterface , PlayPreviewButtonDelegate{
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
    
    func handleCellsAudioOutput(output: previewPlayerOutput) {
        switch output {
        case .play(let indexPath):
            guard let indexPath,let url = tracks[indexPath.row].previewURL else {return}
            presenter?.handleTrackPreviewOutput(output: .playPreview(url))
        case .stop:
            presenter?.handleTrackPreviewOutput(output: .stopPreview)
        }
    }
}
extension HomeController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case rootView.topAlbumsCollectionView:
            self.presenter?.handleViewOutput(output: .goToAlbumDetail(albums[indexPath.row].id))
        case rootView.artistsCollectionView:
            presenter?.handleViewOutput(output: .goToArtistDetail(artists[indexPath.row].id))
        case rootView.popularTracksCollectionView:
            presenter?.handleViewOutput(output: .goToTrackDetail(tracks[indexPath.row].id))
        default:
            break
        }
    }
    
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
            
        case rootView.artistsCollectionView: CGSize(width: 80, height: 100)
        case rootView.topAlbumsCollectionView: CGSize(width: 150, height: 180)
        case rootView.popularTracksCollectionView: CGSize(width: 180, height: 250)
        default: CGSize(width: 0, height: 0)
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case rootView.topAlbumsCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeModuleConstants.albumCell, for: indexPath) as! TopAlbumCell
            let albumAtIndex = albums[indexPath.row]
            cell.configure(with: albumAtIndex)
            return cell
        case rootView.artistsCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeModuleConstants.artistCell, for: indexPath) as! ArtistsCell
            let artistAtIndex = artists[indexPath.row]
            cell.configureData(artist: artistAtIndex)
            return cell
        case rootView.popularTracksCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeModuleConstants.popularTrackCell, for: indexPath) as! PopularTracksCell
            presenter?.transferPreviewPlayableCellToInteractor(delegate: cell as PreviewPlayableCellClient)
            cell.setupIndexPathAndDelegate(viewDelegate : rootView,delegate: self, indexPath: indexPath)
            let trackAtIndex = tracks[indexPath.row]
            cell.configure(track: trackAtIndex)
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}

