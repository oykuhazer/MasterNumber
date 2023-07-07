//
//  GalleryViewController.swift
//  deneme
//
//  Created by Öykü Hazer Ekinci on 2.07.2023.
//

import UIKit

protocol GalleryViewControllerDelegate: AnyObject {
    func didSelectImage(_ image: UIImage)
}
class GalleryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    weak var delegate: GalleryViewControllerDelegate?

    private let imageNames = ["m1", "m2", "m3","m4", "m5", "m6","m7", "m8", "m9","w1", "w2", "w3","w4", "w5", "w6","w7", "w8", "w9","w10","mw","mw2","mw3","mw4","mw5","mw6","mw7","mw8","mw9","mw10","mw11","mw12","mw13"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Configure the collection view layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 80, height: 80)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10

        // Create the collection view
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: "ImageCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
    }



    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageNames.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        
        // Set the image of the cell based on the image name
        cell.imageView.image = UIImage(named: imageNames[indexPath.item])
        return cell
    }



    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectedImage = UIImage(named: imageNames[indexPath.item]) {
            // Call the delegate method to notify the selected image
            delegate?.didSelectImage(selectedImage)
            dismiss(animated: true, completion: nil)
        }
    }
}
