//
//  ImageCell.swift
//  deneme
//
//  Created by Öykü Hazer Ekinci on 2.07.2023.
//

import UIKit

class ImageCell: UICollectionViewCell {
    
    // Image view to display the image
    let imageView: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = 10
            return imageView
        }()

    // Initialize the cell with the provided frame
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupImageView()
        }
    
    // Initialize the cell from a storyboard or nib
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            setupImageView()
        }

        private func setupImageView() {
            addSubview(imageView)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            
            // Set up constraints for the image view to fill the cell's content
            NSLayoutConstraint.activate([
                imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
                imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
                imageView.topAnchor.constraint(equalTo: topAnchor),
                imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        }
    }
