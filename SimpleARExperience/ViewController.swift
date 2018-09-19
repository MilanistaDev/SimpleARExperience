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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
    }

    fileprivate func setUpUI() {
        self.contentsCollectionView.delegate = self
        self.contentsCollectionView.dataSource = self
    }
}

extension ViewController: UICollectionViewDelegate {

}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = UICollectionViewCell()
        return cell
    }
}
