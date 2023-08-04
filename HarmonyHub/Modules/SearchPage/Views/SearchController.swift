//
//  SearchController.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 1.08.2023.
//

import Foundation
import UIKit


final class SearchController : BaseViewController<SearchView> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        rootView.popularPlaylistsCollectionView.delegate = self
        rootView.popularPlaylistsCollectionView.dataSource = self
    }

    
    func setupNavigationController() {
        title = "Let's Discover"
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor : UIColor.white,.font : UIFont(name: "Rockwell", size: 40)!]
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
}
extension SearchController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "playlistCell", for: indexPath) as! PopularPlaylistsCell
        cell.backgroundColor = .blue
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: rootView.popularPlaylistsCollectionView.frame.width / 2 - 5, height: 100)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(rootView.bounds)
    }
}
