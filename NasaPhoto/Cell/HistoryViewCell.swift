//
//  HistoryViewCell.swift
//  NasaPhoto
//
//  Created by Sona on 16.03.24.
//

import UIKit

class HistoryViewCell: UITableViewCell {
    
    static var id: String = "HistoryViewCell.ID"
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var cameraLabel: UILabel!
    @IBOutlet weak var roverLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configUI(info: FilterModel){
        
        roverLabel.attributedText = createSpecialString(normalText: "Rover:  ", boldText: info.rover)
        cameraLabel.attributedText = createSpecialString(normalText: "Camera:  ", boldText: info.camera)
        dateLabel.attributedText = createSpecialString(normalText: "Date:  ", boldText:  info.date.convertDateFormat())
        mainView.layer.masksToBounds = false
        mainView.layer.shadowOpacity = 0.2
        
    }
    
    private func createSpecialString(normalText: String, boldText: String) -> NSMutableAttributedString{
        let normalString = NSMutableAttributedString(string:normalText)
        let attrs = [NSAttributedString.Key.font : UIFont().boldSfPro(size: 16), NSAttributedString.Key.foregroundColor : UIColor.black]
        let attributedString = NSMutableAttributedString(string:boldText, attributes:attrs)
        normalString.append(attributedString)
        return normalString
    }
    
}
