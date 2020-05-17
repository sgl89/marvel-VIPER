//
//  CharacterCell.swift
//  marvel
//
//  Created by Sonia Giraldez on 15/05/2020.
//  Copyright © 2020 Sonia Giraldez. All rights reserved.
//

import UIKit
import AlamofireImage

class CharacterCell: UITableViewCell {

    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configure(_ character: Character) {
        nameLabel.text = character.name
        if let thumbnail = character.thumbnail, let imageUrl = thumbnail.getImageURL() {
            characterImageView.loadImageFromUrlString(imageUrl)
        }
    }
}
