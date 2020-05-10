//
//  ImageDetailViewController.swift
//  NewChallenge
//
//  Created by Felipe Rodriguez on 10/05/2020.
//  Copyright © 2020 Felipe Rodriguez. All rights reserved.
//

import UIKit

class ImageDetailViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var camera: UILabel!
    var imageId: String = ""
    var fullPicture: String = ""
    func setItem() -> Void {
        getImage(successCallback: {(image: ImageDetail) -> Void in
            setImage(from: image.fullPicture, imageView: self.imageView)
            self.author.text = image.author
            self.camera.text = image.camera
            self.fullPicture = image.fullPicture
            self.scrollview.addSubview(self.imageView)
        }, id: self.imageId)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollview.minimumZoomScale = 0.1
        scrollview.maximumZoomScale = 4.0
        scrollview.zoomScale = 1.0
        scrollview.delegate = self as? UIScrollViewDelegate
        self.setItem()
    }
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    @IBAction func share(_ sender: UIButton) {
       let objectsToShare: [Any] = [NSURL(string: self.fullPicture)]
       let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)

       activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]

       activityVC.popoverPresentationController?.sourceView = sender
       self.present(activityVC, animated: true, completion: nil)
    }
}
