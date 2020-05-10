//
//  Utils.swift
//  NewChallenge
//
//  Created by Felipe Rodriguez on 03/05/2020.
//  Copyright © 2020 Felipe Rodriguez. All rights reserved.
//
import UIKit

func setImage(from url: String, imageView: UIImageView) {
    guard let imageURL = URL(string: url) else { return }

        // just not to cause a deadlock in UI!
    DispatchQueue.global().async {
        guard let imageData = try? Data(contentsOf: imageURL) else { return }

        let image = UIImage(data: imageData)
        DispatchQueue.main.async {
            imageView.image = image
        }
    }
}

