//
//  ViewController.swift
//  SimpleARExperience
//
//  Created by 麻生 拓弥 on 2018/09/18.
//  Copyright © 2018年 com.ASTK. All rights reserved.
//

import UIKit
import QuickLook

final class ViewController: UIViewController {

    @IBOutlet weak var contentsCollectionView: UICollectionView!

    // USDZファイル名のArray
    fileprivate let contentsArray: [String] = ["cupandsaucer", "gramophone", "plantpot",
                                           "redchair", "retrotv", "teapot", "trowel",
                                           "tulip", "wateringcan", "wheelbarrow"]
    // セルを押した際のCollectionViewのindex値
    fileprivate var selectedItemIndex: Int = -1

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

    fileprivate func previewARContents() {
        let previewController = QLPreviewController()
        previewController.dataSource = self
        self.present(previewController, animated: true, completion: nil)
    }
}

// MARK: - UICollectionViewDelegate

extension ViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // CollectionViewのセルをタップしたindex値を保持しておく
        self.selectedItemIndex = indexPath.row
        // QLPreviewControllerを開く
        let previewController = QLPreviewController()
        previewController.dataSource = self
        self.present(previewController, animated: true, completion: nil)
    }
}

// MARK: - UICollectionViewDataSource

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

// MARK: - UICollectionViewDelegateFlowLayout

extension ViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = UIScreen.main.bounds.width / 2 - 7.5
        let height = width
        return CGSize(width: width, height: height)
    }
}

// MARK:- QLPreviewController DataSource

extension ViewController: QLPreviewControllerDataSource {

    /// Quick Look で表示するアイテム数
    ///
    /// - Parameter controller: controller
    /// - Returns: Quick Look で表示するアイテム数
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 1
    }

    /// Quick Look で表示するアイテムを返す
    ///
    /// - Parameters:
    ///   - controller: controller
    ///   - index: アイテムのindex値
    /// - Returns: Quick Look で表示するアイテム
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        // Return the file URL to the .usdz file
        let fileUrl = (self.selectedItemIndex < 0) ?
            Bundle.main.url(forResource: "cupandsaucer", withExtension: "usdz")! :
            Bundle.main.url(forResource: self.contentsArray[self.selectedItemIndex], withExtension: "usdz")!
        return fileUrl as QLPreviewItem
    }
}
