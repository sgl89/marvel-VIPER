//
//  CharacterDetailViewController.swift
//  marvel
//
//  Created by Sonia Giraldez on 16/05/2020.
//  Copyright © 2020 Sonia Giraldez. All rights reserved.
//

import Foundation
import UIKit

class CharacterDetailViewController: UIViewController {
    var presenter: CharacterDetailPresenterProtocol!
    
    @IBOutlet weak var characterImageView: UIImageView!
    
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var nameTitleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var descriptionTitleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var comicsView: UIView!
    @IBOutlet weak var comicsTitleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        localizeStrings()
        
        presenter.viewDidLoad()
    }
    
    func configureView() {
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().barTintColor = UIColor.clear
        
        collectionView.register(UINib(nibName: DetailConstants.kCellIdentifier,
                                      bundle: nil),
                                forCellWithReuseIdentifier: DetailConstants.kCellIdentifier)
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 0.3 * collectionView.bounds.width, height: collectionView.frame.size.height)
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
    }
    
    func localizeStrings() {
        nameTitleLabel.text = "Name".localized
        descriptionTitleLabel.text = "Description".localized
        comicsTitleLabel.text = "Comics".localized
    }
}

//----------------------------
// MARK: - Protocol
//----------------------------
extension CharacterDetailViewController: CharacterDetailViewProtocol{
    func showDetail() {
        characterImageView.loadImageFromUrlString(presenter.getImage())
        
        title = presenter.getName()
        nameLabel.text = presenter.getName()
        
        descriptionLabel.text = presenter.getDescription()
        descriptionView.isHidden = presenter.getDescription().isEmpty
        
        comicsView.isHidden = presenter.getComics().isEmpty
        collectionView.reloadData()
    }
}

//----------------------------
// MARK: - CollectionView configuration
//----------------------------
extension CharacterDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.getComics().count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailConstants.kCellIdentifier,
                                                      for: indexPath) as! ComicCell

        cell.configureWithComic(presenter.getComics()[indexPath.row])

        return cell
    }
}
