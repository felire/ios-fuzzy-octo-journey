//
//  ViewController.swift
//  NewChallenge
//
//  Created by Felipe Rodriguez on 03/05/2020.
//  Copyright © 2020 Felipe Rodriguez. All rights reserved.
//

import UIKit


class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    var items: [Image] = []
    var nextPage: Int = 1
    var totalPages: Int = 1
    var callingApi: Bool = false
    func setItems() -> Void {
        if(nextPage <= totalPages){
            callingApi = true
            getImages(successCallback: {(newImages: Images) -> Void in
                let fromUpdate: Int = self.items.count
                self.items += newImages.pictures
                self.totalPages = newImages.pageCount
                self.nextPage = newImages.page + 1
                self.collectionView.reloadData()
                self.callingApi = false
                if(fromUpdate == 0){
                    self.collectionView.reloadData()
                }else{
                    let indexPaths = Array(fromUpdate...self.items.count - 1).map { IndexPath(item: $0, section: 0) }
                    self.collectionView.reloadItems(at: indexPaths)
                }
            }, page: self.nextPage)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        auth()
        self.setItems()
        collectionView.delegate = self
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical //.horizontal
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        collectionView.backgroundColor = UIColor.clear
        collectionView.setCollectionViewLayout(layout, animated: true)
        // Do any additional setup after loading the view.
    }

    let reuseIdentifier = "cell"
    

    // MARK: - UICollectionViewDataSource protocol
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 1.0, left: 1.0, bottom: 1.0, right: 1.0)//here your custom value for spacing
        }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                let lay = collectionViewLayout as! UICollectionViewFlowLayout
                let widthPerItem = collectionView.frame.width / 2 - lay.minimumInteritemSpacing

    return CGSize(width:widthPerItem, height:widthPerItem)
    }
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }

    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! ImageCollectionViewCell
        setImage(from: self.items[indexPath.item].croppedPicture, imageView: cell.imageView)
        cell.imageView.layer.cornerRadius = 8
        cell.imageView.layer.masksToBounds = true
        return cell
    }

    // MARK: - UICollectionViewDelegate protocol

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let imageDetailViewController = ImageDetailViewController()
        imageDetailViewController.imageId = items[indexPath.item].id
        self.navigationController?.pushViewController(imageDetailViewController, animated: true)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let bottomEdge: CGFloat = scrollView.contentOffset.y + scrollView.frame.size.height;
        if (bottomEdge >= scrollView.contentSize.height) {
            if(!callingApi){
                self.setItems()
            }
        }
    }

}

