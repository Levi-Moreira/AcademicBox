//
//  MaterialsViewController.swift
//  AcademicBox
//
//  Created by Alan Jeferson on 15/07/17.
//  Copyright © 2017 IFCE. All rights reserved.
//

import UIKit

class MaterialsViewController: UIViewController, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let kCollectionViewCellImagesIdentifier = "CollectionViewCellMaterialsImages"
    
    var material: Materials!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    func setupView() {
        self.collectionView.dataSource = self
        self.collectionView.reloadData()
        self.downloadImage(atIndex: 0)
    }
    
    func downloadImages() {
        for i in 0..<self.material.images.count {
            self.downloadImage(atIndex: i)
        }
    }
    
    func downloadImage(atIndex index: Int) {
        let image = self.material.images[index]
        image.download { [weak self] error in
            self?.collectionView.reloadItems(at: [IndexPath(item: index, section: 0)])
        }
    }
    
    
    // MARK:- CollectionView DataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.material.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.kCollectionViewCellImagesIdentifier, for: indexPath) as? MaterialsImagesCollectionViewCell {
            cell.fill(image: self.material.images[indexPath.row])
            return cell
        }
        
        return UICollectionViewCell()
        
    }

}
