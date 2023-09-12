//
//  SearchView.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 1.08.2023.
//

import Foundation
import UIKit

class SearchView: UIView, PreviewPlayerViewClient {

    lazy var scrollView = UIScrollView()

    lazy var popularPlaylistsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        var collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .black
        collectionView.isPagingEnabled = false
        collectionView.showsVerticalScrollIndicator = false // Enable scrolling
        collectionView.backgroundColor = .black
        collectionView.isScrollEnabled = false
        collectionView.register(PopularPlaylistsCell.self, forCellWithReuseIdentifier: SearchModuleConstants.playlistCell)
        return collectionView
    }()
    
    lazy var searchResultsTableView : UITableView = {
        var tableView = UITableView()
        tableView.register(TrackListCell.self, forCellReuseIdentifier: TrackListCell.identifier)
        tableView.isHidden = true
        tableView.isUserInteractionEnabled = true
        tableView.keyboardDismissMode = .onDrag
        return tableView
    }()

    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = SearchModuleConstants.searchBarPlaceholder
        searchBar.backgroundColor = .label
        searchBar.barTintColor = .label
        return searchBar
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        scrollView.keyboardDismissMode = .onDrag
        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: 1300)
        addSubviews()
        setupSearchBarConstraints()
        setupScrollViewConstraints()
        setupSearchResultsTableViewConstraints()
        setupCollectionViewConstraints()
    }

    func searchStarted(_ isStarted : Bool) {
        self.popularPlaylistsCollectionView.isHidden = isStarted
        self.searchResultsTableView.isHidden = !isStarted
        self.scrollView.isScrollEnabled = !isStarted
        self.searchResultsTableView.reloadData()
        if isStarted {
            scrollView.setContentOffset(CGPointZero, animated: true)
        }
    }

    func restartTrackCellPreviewButton(url : URL) {
        searchResultsTableView.visibleCells.filter({$0.asTrackListCell().ownerTrack.previewURL != url}).forEach( {
            $0.asTrackListCell().playPreviewButton.setTitle(PreviewButtonIcons.play, for: .normal)
                $0.asTrackListCell().isPlaying = false
        })
    }
    
    func addSubviews() {
        [searchBar,scrollView].forEach({ addSubview($0) })
        [searchResultsTableView,popularPlaylistsCollectionView].forEach({ scrollView.addSubview($0)})
    }

    func setupCollectionViewConstraints() {
        popularPlaylistsCollectionView.snp.makeConstraints { make in
            make.width.equalTo(self.snp.width)
            make.bottom.equalTo(self.snp.bottom)
            make.leading.trailing.equalTo(self)
            make.top.equalTo(scrollView.snp.bottom) // Change this line
        }
    }

    func setupScrollViewConstraints() {
        // Adjust the contentSize to fit your content
        scrollView.snp.makeConstraints { make in
            make.centerX.bottom.width.equalTo(self.safeAreaLayoutGuide)
            make.top.equalTo(searchBar.snp.bottom).offset(20)
        }
    }
    
    func setupSearchResultsTableViewConstraints() {
        searchResultsTableView.snp.makeConstraints { make in
            make.width.equalTo(self.snp.width)
            make.bottom.equalTo(self.snp.bottom)
            make.leading.trailing.equalTo(self)
            make.top.equalTo(scrollView.snp.bottom) // Change this line
        }
    }
    
    func setupSearchBarConstraints() {
        searchBar.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(self.snp.width)
            make.leading.equalTo(self.snp.leading)
            make.trailing.equalTo(self.snp.trailing)
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
