//
//  FullScreenImageViewController.swift
//  NasaPhoto
//
//  Created by Sona on 15.03.24.
//

import UIKit
import Kingfisher

class FullScreenImageViewController: UIViewController,UIScrollViewDelegate {
    
    var imageView = UIImageView()
    var scrollView = UIScrollView()
    var imgString: String = ""
    
    lazy var closeButton: UIButton = {
        let bt = UIButton()
        bt.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        bt.setImage(UIImage(named: "close.icon"), for: .normal)
        view.addSubview(bt)
        return bt
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        configUI()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        scrollView.frame = view.bounds
        imageView.frame = scrollView.bounds
        closeButton.frame = CGRect(x: 16, y: 70, width: 44, height: 44)
    }
    
    private func configUI(){
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 6.0
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        scrollView.backgroundColor = UIColor.black
        self.view.backgroundColor = UIColor.black
        
        if let imgUrl = URL(string: imgString) {
            let resource = KF.ImageResource(downloadURL: imgUrl, cacheKey: imgString)
            imageView.kf.setImage(with: resource)
        }
        
        imageView.contentMode = .scaleAspectFit
        scrollView.addSubview(imageView)
        view.addSubview(scrollView)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    
    @objc func backAction(){
        self.navigationController?.popViewController(animated: true)
    }
    
}
