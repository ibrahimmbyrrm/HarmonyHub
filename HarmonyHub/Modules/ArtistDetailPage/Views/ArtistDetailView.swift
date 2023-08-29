//
//  ArtistDetailView.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 13.08.2023.
//

import Foundation
import UIKit

class ArtistDetailView : UIView {
    
    lazy var artistImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 70
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor.systemIndigo.cgColor
        imageView.layer.borderWidth = 3
        imageView.backgroundColor = .black
        return imageView
    }()
    
    lazy var artistStatsStackView = ArtistDetailStackView()
    
    lazy var tracksTableView : UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .black
        tableView.isScrollEnabled = true
        tableView.register(TrackListCell.self, forCellReuseIdentifier: AlbumDetailModuleConstants.trackCell)
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .black
        addSubviews()
        setupArtistImageViewConstraints()
        setupArtistStatsStackViewConstraints()
        setupTracksTableViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func addSubviews() {
        [artistImageView,artistStatsStackView,tracksTableView].forEach({ self.addSubview($0) })
    }
    private func setupArtistStatsStackViewConstraints() {
        artistStatsStackView.snp.makeConstraints { make in
            make.leading.equalTo(self.artistImageView.snp.trailing).offset(10)
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(5)
            make.trailing.equalTo(self.snp.trailing).inset(5)
            make.height.equalTo(140)
            
        }
    }
    private func setupTracksTableViewConstraints() {
        tracksTableView.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading)
            make.trailing.equalTo(self.snp.trailing)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
            make.top.equalTo(self.artistImageView.snp.bottom).offset(20)
        }
    }

    private func setupArtistImageViewConstraints() {
        artistImageView.snp.makeConstraints { make in
            make.width.height.equalTo(140)
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(5)
            make.leading.equalTo(self.snp.leading).offset(5)
        }
    }
    
}
