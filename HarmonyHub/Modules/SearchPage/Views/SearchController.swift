//
//  SearchController.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 1.08.2023.
//

import Foundation
import UIKit


final class SearchController : BaseViewController<SearchView> {
    
    var presenter: SearchPresenterInterface?
    lazy var playlists = [PlaylistsDatum]()
    lazy var searchResults = [TracksDatum]()
    var searchQueryTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        presenter?.handleTrackPreviewOutput(output: .stopPreview)
    }
    
    func getPlaylists() {
        presenter?.handleViewOutput(output: .loadPlaylists)
    }
    
    func setDelegates() {
        rootView.popularPlaylistsCollectionView.delegate = self
        rootView.popularPlaylistsCollectionView.dataSource = self
        rootView.searchResultsTableView.delegate = self
        rootView.searchResultsTableView.dataSource = self
        rootView.searchBar.delegate = self
    }
    
    func setupNavigationController() {
        title = SearchModuleConstants.pageTitle
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor : UIColor.white,.font : UIFont(name: FontNames.rockwell, size: 40)!]
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }

    
}
extension SearchController : UISearchBarDelegate {
    //Wait 0.5 second after user finished to enter a search text.
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let isSearching = !searchText.isEmpty
        searchResults = isSearching ? [TracksDatum]() : []
        rootView.searchStarted(isSearching)
        searchQueryTimer?.invalidate()
        if isSearching {
            searchQueryTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
                self.presenter?.handleViewOutput(output: .fetchSearchResults(searchText))
            }
        }
    }
    
}

extension SearchController : SearchViewInterface {
    func handlePresenterOutput(output: SearchPresenterToViewOutput) {
        switch output {
        case .playlistsLoaded(let playlists):
            DispatchQueue.main.async {
                self.playlists = playlists
                self.rootView.popularPlaylistsCollectionView.reloadData()
            }
        case .queryResultsLoaded(let tracks):
            DispatchQueue.main.async {
                self.searchResults = tracks
                self.rootView.searchResultsTableView.reloadData()
            }
        }
    }
}

extension SearchController : UITableViewDelegate, UITableViewDataSource, PlayPreviewButtonDelegate {
    
    func handleCellsAudioOutput(output: previewPlayerOutput) {
        switch output {
        case .play(let indexPath):
            guard let indexPath,let url = searchResults[indexPath.row].previewURL else {return}
            presenter?.handleTrackPreviewOutput(output: .playPreview(url))
        case .stop:
            presenter?.handleTrackPreviewOutput(output: .stopPreview)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchModuleConstants.searchCell, for: indexPath) as! TrackListCell
        presenter?.transferPreviewPlayableCellToInteractor(delegate: cell as PreviewPlayableCellClient)
        cell.setupIndexPathAndDelegate(viewDelegate : rootView,delegate: self, indexPath: indexPath)
        cell.configure(track: searchResults[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.handleViewOutput(output: .trackSelected(searchResults[indexPath.row]))
    }
    
}
extension SearchController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return playlists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchModuleConstants.playlistCell, for: indexPath) as! PopularPlaylistsCell
        let itemAtIndex = playlists[indexPath.row]
        cell.configure(playlist: itemAtIndex)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 189, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.handleViewOutput(output: .platlistSelected(playlists[indexPath.row]))
    }
}
