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

final class HomeView : UIViewController,HomeViewInterface{
    var presenter: HomePresenterInterface?
    
    let buttonsStackView = MediaButtonsStackView()
    let scrollView = UIScrollView()
    var list = [String?]() {
        didSet {
            print("set edildi")
            topAlbumsCollectionView.reloadData()
        }
    }
    private lazy var topAlbumsCollectionView : UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.register(TopAlbumCell.self, forCellWithReuseIdentifier: "topAlbumCell")
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = false
        return collectionView
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topAlbumsCollectionView.delegate = self
        topAlbumsCollectionView.dataSource = self
        addSubviews()
        setupNavigationController()
        buttonsStackView.musicButton.backgroundColor = .systemIndigo
        setupScrollViewConstraints()
        Service().fetch { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let albums):
                    let urls = albums.map { $0.coverMedium }
                    self.list = urls
                case .failure(let error):
                    print("error")
                }
            }
        }

    }
    
    func setupNavigationController() {
        view.backgroundColor = .black
        title = "HarmonyHub"
        self.navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor : UIColor.white,.font : UIFont(name: "Rockwell", size: 44)!]
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func addSubviews(){
        view.addSubview(scrollView)
        scrollView.addSubview(topAlbumsCollectionView)
        scrollView.addSubview(buttonsStackView)
        buttonsStackView.albumButton.addTarget(nil, action: #selector(tapped), for: .touchUpInside)
    }
    
    @objc func tapped() {
        print("tapped")
    }
    
    func setupScrollViewConstraints(){
        scrollView.snp.makeConstraints { make in
            make.centerX.top.bottom.width.equalTo(view.safeAreaLayoutGuide)
        }
        
        topAlbumsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(buttonsStackView.snp.bottom).offset(30)
            make.leading.equalTo(view.snp.leading).offset(10)
            make.trailing.equalTo(view.snp.trailing).inset(10)
            make.height.equalTo(180)
        }
        
    }
    func setupButtonsStackViewConstraints(){
        buttonsStackView.snp.makeConstraints { make in
            make.width.equalTo(285)
            make.leading.equalTo(self.scrollView.snp.leading).offset(10)
            make.height.equalTo(42)
            make.top.equalTo(self.scrollView.snp.top).offset(20)
        }
    }
    
}
extension HomeView : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "topAlbumCell", for: indexPath) as! TopAlbumCell
        cell.backgroundColor = .black
        cell.albumName.text = "Album Name"
        DispatchQueue.main.async {
            if self.list.count > 0 {
                cell.albumImage.setImage(with: self.list[indexPath.row]!)
            }
        }
        cell.artistName.text = "Artist"
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("selectred")
    }
}
class Service {
    let url = URL(string: "https://api.deezer.com/chart/tracks")!
    
    func fetch(completion : @escaping (Result<[AlbumsDatum],Error>)->Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            print("started")
            guard let data else {return}
            print("data unwrapped")
            let decoded = try? JSONDecoder().decode(Welcome.self, from: data)
            guard let decoded else {return}
            print("decoded unwrapped")
            completion(.success((decoded.albums?.data!)!))
        }.resume()
    }
}
