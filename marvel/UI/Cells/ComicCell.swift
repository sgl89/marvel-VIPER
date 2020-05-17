//
//  ComicCell.swift
//  marvel
//
//  Created by Sonia Giraldez on 17/05/2020.
//  Copyright © 2020 Sonia Giraldez. All rights reserved.
//

import UIKit

class ComicCell: UICollectionViewCell {

    @IBOutlet weak var comicImageView: UIImageView!
    @IBOutlet weak var comicLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureWithComic(_ comic: Comic) {
        comicLabel.text = comic.title
        if let thumbnail = comic.thumbnail, let imageUrl = thumbnail.getImageURL() {
            comicImageView.loadImageFromUrlString(imageUrl)
        }
    }

}
