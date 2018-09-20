//
//  ContentsCollectionViewCell.swift
//  SimpleARExperience
//
//  Created by 麻生 拓弥 on 2018/09/19.
//  Copyright © 2018年 com.ASTK. All rights reserved.
//

import UIKit

class ContentsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var contentsImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 5.0
        self.layer.masksToBounds = true
    }
}
