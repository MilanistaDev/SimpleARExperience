//
//  ViewController.swift
//  SimpleARExperience
//
//  Created by 麻生 拓弥 on 2018/09/18.
//  Copyright © 2018年 com.ASTK. All rights reserved.
//

import UIKit
import QuickLook
import SafariServices

final class ViewController: UIViewController {

    @IBOutlet weak var contentsCollectionView: UICollectionView!

    private enum ContentType: Int, CaseIterable {
        case web
        case usdz
    }

    // Web Contents Tuple(Mac Pro & Pro Display XDR)
    private let webContentsArray: [(name: String, url: String)] =
        [("macPro", "https://www.apple.com/jp/mac-pro/"),
         ("proDisplayXDR", "https://www.apple.com/jp/pro-display-xdr/")]

    // USDZファイル名のArray
    private let contentsArray: [String] = ["cupandsaucer", "stratocaster", "gramophone",
                                           "plantpot", "redchair", "retrotv", "teapot",
                                           "trowel", "tulip", "wateringcan", "wheelbarrow"]
    // セルを押した際のCollectionViewのindex値
    private var selectedItemIndex: Int = -1

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
    }

    private func setUpUI() {
        self.navigationItem.title = "Simple AR Experience"
        self.contentsCollectionView.delegate = self
        self.contentsCollectionView.dataSource = self
        let cellNib = UINib(nibName: "ContentsCollectionViewCell", bundle: nil)
        self.contentsCollectionView.register(cellNib, forCellWithReuseIdentifier: "ContentsCell")
    }

    private func previewARContents() {
        let previewController = QLPreviewController()
        previewController.dataSource = self
        self.present(previewController, animated: true, completion: nil)
    }
}

// MARK: - UICollectionViewDelegate

extension ViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case ContentType.web.rawValue:
            let url = URL(string: self.webContentsArray[indexPath.row].url)
            let safariVC = SFSafariViewController(url: url!)
            self.present(safariVC, animated: true, completion: nil)
        default:
            // CollectionViewのセルをタップしたindex値を保持しておく
            self.selectedItemIndex = indexPath.row
            // QLPreviewControllerを開く
            self.previewARContents()
        }
    }
}

// MARK: - UICollectionViewDataSource

extension ViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return ContentType.allCases.count
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case ContentType.web.rawValue:
            return self.webContentsArray.count
        default:
            return self.contentsArray.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentsCell", for: indexPath) as! ContentsCollectionViewCell
        switch indexPath.section {
        case ContentType.web.rawValue:
            cell.contentsImageView.image = UIImage(named: self.webContentsArray[indexPath.row].name)
        default:
            cell.contentsImageView.image = UIImage(named: self.contentsArray[indexPath.row])
        }
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
