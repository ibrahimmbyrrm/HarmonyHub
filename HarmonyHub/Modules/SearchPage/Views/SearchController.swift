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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
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
        title = "Let's Discover"
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor : UIColor.white,.font : UIFont(name: "Rockwell", size: 40)!]
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
}
extension SearchController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        rootView.searchStarted(searchText.count > 0)
        searchText.count > 0 ? presenter?.handleViewOutput(output: .fetchSearchResults(searchText)) : nil
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

extension SearchController : UITableViewDelegate, UITableViewDataSource, PreviewButtonDelegate {
    
    func handleCellsAudioOutput(output: previewPlayerOutput) {
        switch output {
        case .play(let indexPath):
            presenter?.handleTrackPreviewOutput(output: .playPreview(searchResults[indexPath.row]))
        case .stop:
            presenter?.handleTrackPreviewOutput(output: .stopPreview)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as! SearchResultCell
        cell.setupIndexPathAndDelegate(delegate: self, indexPath: indexPath)
        cell.configure(track: searchResults[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
extension SearchController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return playlists.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "playlistCell", for: indexPath) as! PopularPlaylistsCell
        let itemAtIndex = playlists[indexPath.row]
        cell.configure(playlist: itemAtIndex)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 189, height: 250)
    }
}
