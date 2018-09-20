//
//  ViewController.swift
//  SimpleARExperience
//
//  Created by 麻生 拓弥 on 2018/09/18.
//  Copyright © 2018年 com.ASTK. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {

    @IBOutlet weak var contentsCollectionView: UICollectionView!

    // USDZファイル名のArray
    private let contentsArray: [String] = ["cupandsaucer", "gramophone", "plantpot",
                                           "redchair", "retrotv", "teapot", "trowel",
                                           "tulip", "wateringcan", "wheelbarrow"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
    }

    fileprivate func setUpUI() {
        self.navigationItem.title = "Simple AR Experience"
        self.contentsCollectionView.delegate = self
        self.contentsCollectionView.dataSource = self
        let cellNib = UINib(nibName: "ContentsCollectionViewCell", bundle: nil)
        self.contentsCollectionView.register(cellNib, forCellWithReuseIdentifier: "ContentsCell")
    }
}

extension ViewController: UICollectionViewDelegate {

}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.contentsArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentsCell", for: indexPath) as! ContentsCollectionViewCell
        cell.contentsImageView.image = UIImage(named: self.contentsArray[indexPath.row])
        return cell
    }
}

// MARK:- UICollectionViewDelegateFlowLayout

extension ViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = UIScreen.main.bounds.width / 2 - 7.5
        let height = width
        return CGSize(width: width, height: height)
    }
}
