//
//  MainViewCell.swift
//  NasaPhoto
//
//  Created by Sona on 13.03.24.
//

import UIKit
import Kingfisher

class MainViewCell: UITableViewCell {
    
    static var id: String = "MainViewCell.ID"
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var roverText: UILabel!
    @IBOutlet weak var cameraText: UILabel!
    @IBOutlet weak var dataText: UILabel!
    @IBOutlet weak var marsPhoto: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configUI(info: Info){
        
        roverText.attributedText = createSpecialString(normalText: "Rover:  ", boldText: info.rover.name)
        cameraText.attributedText = createSpecialString(normalText: "Camera:  ", boldText: info.camera.fullName)
        dataText.attributedText = createSpecialString(normalText: "Date:  ", boldText:  info.earthDate.convertDateFormat())
        
        if let imgUrl = URL(string: info.imgSrc) {
            let resource = KF.ImageResource(downloadURL: imgUrl, cacheKey: info.imgSrc)
            marsPhoto.kf.setImage(with: resource)
        }
        mainView.layer.masksToBounds = false
        mainView.layer.shadowOpacity = 0.2
    }
    
    private func createSpecialString(normalText: String, boldText: String) -> NSMutableAttributedString{
        let normalString = NSMutableAttributedString(string:normalText, attributes: [NSAttributedString.Key.font : UIFont().regularSfPro(size: 16)])

        let attrs = [NSAttributedString.Key.font : UIFont().boldSfPro(size: 16), NSAttributedString.Key.foregroundColor : UIColor.black]
        let attributedString = NSMutableAttributedString(string:boldText, attributes:attrs)
        
        normalString.append(attributedString)
        
        return normalString
    }
}
