//
//  HomeVieww.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 1.08.2023.
//

import Foundation
import UIKit
import AVFoundation

class HomeView : UIView, PreviewPlayerViewClient {
    //MARK: - UI Objects
    lazy var topAlbumsCollectionView : UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.register(TopAlbumCell.self, forCellWithReuseIdentifier: HomeModuleConstants.albumCell)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .label
        collectionView.isPagingEnabled = false
        return collectionView
        
    }()
    lazy var artistsCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = false
        collectionView.backgroundColor = .black
        collectionView.register(ArtistsCell.self, forCellWithReuseIdentifier: HomeModuleConstants.artistCell)
        return collectionView
    }()
    lazy var popularTracksCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        var collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .black
        collectionView.isPagingEnabled = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .black
        collectionView.isScrollEnabled = false
        collectionView.register(PopularTracksCell.self, forCellWithReuseIdentifier: HomeModuleConstants.popularTrackCell)
        return collectionView
    }()
    lazy var artistsLabel = HomeTitleLabel()
    lazy var popularTracksLabel = HomeTitleLabel()
    lazy var buttonsStackView = MediaButtonsStackView()
    lazy var scrollView = UIScrollView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        artistsLabel.text = HomeModuleConstants.artistTitle
        popularTracksLabel.text = HomeModuleConstants.tracksTitle
        buttonsStackView.isUserInteractionEnabled = false
        addSubviews()
        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: 1500)
        setupScrollViewConstraints()
        setupArtistsLabelConstraints()
        setupButtonsStackViewConstraints()
        setupArtistsCollectionViewConstraints()
        setupTopAlbumsCollectionViewConstraints()
        setupPopularTracksLabelConstraints()
        setupPopularTracksCollectionViewConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    typealias CollectionViewDelegate = UICollectionViewDelegate & UICollectionViewDataSource & UICollectionViewDelegateFlowLayout
    
    func setCollectionViewDelegates(_ delegate : CollectionViewDelegate) {
        [topAlbumsCollectionView,artistsCollectionView,popularTracksCollectionView].forEach({
            $0.delegate = delegate
            $0.dataSource = delegate
        })
    }
    
    func restartTrackCellPreviewButton(url : URL) {
        popularTracksCollectionView.visibleCells.filter({$0.asTrackCell().ownerTrack.previewURL != url}).forEach( {
            $0.asTrackCell().playPreviewButton.setTitle(PreviewButtonIcons.play, for: .normal)
            $0.asTrackCell().isPlaying = false
        })
    }
    
    func reloadCollectionViews() {
            [self.topAlbumsCollectionView,self.artistsCollectionView,self.popularTracksCollectionView].forEach({ $0.reloadData() })
    }
    
    func addSubviews(){
        addSubview(scrollView)
        [topAlbumsCollectionView,buttonsStackView,artistsLabel,artistsCollectionView,popularTracksLabel,popularTracksCollectionView].forEach({ scrollView.addSubview($0) })
    }
    
    func setupPopularTracksCollectionViewConstraints() {
        popularTracksCollectionView.snp.makeConstraints { make in
            make.top.equalTo(popularTracksLabel.snp.bottom).offset(12)
            make.leading.equalTo(self.snp.leading).offset(10)
            make.trailing.equalTo(self.snp.trailing).inset(10)
            make.height.equalTo(1000)
        }
    }
    
    func setupPopularTracksLabelConstraints() {
        popularTracksLabel.snp.makeConstraints { make in
            make.leading.equalTo(10)
            make.height.equalTo(40)
            make.top.equalTo(artistsCollectionView.snp.bottom).offset(12)
        }
    }
    
    func setupArtistsLabelConstraints() {
        artistsLabel.snp.makeConstraints { make in
            make.leading.equalTo(10)
            make.top.equalTo(topAlbumsCollectionView.snp.bottom).offset(12)
        }
    }
    func setupArtistsCollectionViewConstraints() {
        artistsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(artistsLabel.snp.bottom).offset(10)
            make.leading.equalTo(self.snp.leading).offset(10)
            make.trailing.equalTo(self.snp.trailing).inset(10)
            make.height.equalTo(85)
        }
    }
    func setupTopAlbumsCollectionViewConstraints() {
        topAlbumsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(buttonsStackView.snp.bottom).offset(30)
            make.leading.equalTo(self.snp.leading).offset(10)
            make.trailing.equalTo(self.snp.trailing).inset(10)
            make.height.equalTo(180)
        }
    }
    func setupScrollViewConstraints() {
        scrollView.snp.makeConstraints { make in
            make.centerX.top.bottom.width.equalTo(self.safeAreaLayoutGuide)
        }
    }
    func setupButtonsStackViewConstraints() {
        buttonsStackView.snp.makeConstraints { make in
            make.width.equalTo(285)
            make.leading.equalTo(self.scrollView.snp.leading).offset(10)
            make.height.equalTo(42)
            make.top.equalTo(self.scrollView.snp.top).offset(20)
        }
        buttonsStackView.musicButton.backgroundColor = .systemIndigo
    }
}
