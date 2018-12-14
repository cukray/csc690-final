//
//  ViewController.swift
//  AR Decor
//
//  Created by CUK on 12/13/18.
//  Copyright © 2018 U Keong Cheong. All rights reserved.
//

import UIKit
import QuickLook

class ViewController: UIViewController {
    
    let models = ["wateringcan", "teapot", "gramophone", "cupandsaucer", "redchair", "tulip", "plantpot", "wheelbarrow", "iphone7", "retrotv", "stratocaster", "trowel"]
    
    @IBOutlet weak var collectionVIew: UICollectionView!
    var thumbnails = [UIImage]()
    var thumbnailIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for model in models {
            if let thumbnail = UIImage(named: "\(model).jpg") {
                thumbnails.append(thumbnail)
            }
        }
        // Do any additional setup after loading the view, typically from a nib.
        
        collectionVIew.dataSource = self
        collectionVIew.delegate = self
        collectionVIew.reloadData()
    }


}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? cellClass
        
        if let cell = cell {
            cell.modelThumbnail.image = thumbnails[indexPath.item]
            let title = models[indexPath.item]
            cell.modelTitle.text = title.capitalized
        }
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        thumbnailIndex = indexPath.item
        let previewController = QLPreviewController()
        previewController.dataSource = self
        previewController.delegate = self
        present(previewController, animated: true)
    }
    
    
}

extension ViewController: QLPreviewControllerDelegate, QLPreviewControllerDataSource {
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 1
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        let url = Bundle.main.url(forResource: models[thumbnailIndex], withExtension: "usdz")!
        return url as QLPreviewItem
    }
    
    
}
