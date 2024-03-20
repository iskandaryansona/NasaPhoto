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
    
    private var viewModel: RoversViewModel = RoversViewModel()
    
    var subscriber = Set<AnyCancellable>()

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
        bindingViewModel()
        configAnimation()
    }
    
    private func configAnimation(){
        lottieAnimation.play()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            self.viewModel.getRoversList(page: 0)
        }
    }
    
    private func bindingViewModel(){
        self.viewModel.$roversList
            .compactMap({ $0 })
            .sink { [weak self] data in
                self?.lottieAnimation.stop()
                self?.presentMain(data: data)
            }.store(in: &subscriber)
    }
    
    
    private func presentMain(data: [Info]){
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let mainVC = storyboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        mainVC.roverInfo = data
        self.navigationController?.pushViewController(mainVC, animated: false)
    }
    
    
}

