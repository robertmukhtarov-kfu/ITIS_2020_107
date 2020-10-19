//
//  ImageViewController.swift
//  TableViewTest
//
//  Created by Teacher on 19.10.2020.
//

import UIKit

class ImageViewController: UIViewController {
    var image: UIImage? {
        didSet {
            updateImage()
        }
    }
    
    @IBOutlet private var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateImage()
    }
    
    private func updateImage() {
        imageView.image = image
    }
}
