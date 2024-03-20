//
//  ViewController.swift
//  NasaPhoto
//
//  Created by Sona on 13.03.24.
//

import UIKit
import Lottie
import Combine

class ViewController: UIViewController {
    
    @IBOutlet weak var containerLottie: UIView!
        

    private var lottieAnimation: LottieAnimationView {
        if let animationPath = Bundle.main.path(forResource: "lottie-animation", ofType: "json") {
            let anime: LottieAnimationView = .init(filePath: animationPath)
            anime.frame = containerLottie.bounds
            anime.contentMode = .scaleAspectFill
            anime.loopMode = .loop
            anime.animationSpeed = 1.0
            containerLottie.addSubview(anime)
            
             return anime
        }
        return LottieAnimationView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configAnimation()
    }
    
    private func configAnimation(){
        lottieAnimation.play()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 7){
            self.presentMain()
        }
    }
    
    
    private func presentMain(){
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let mainVC = storyboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        self.navigationController?.pushViewController(mainVC, animated: false)
    }
    
    
}

