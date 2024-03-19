//
//  Extension + UIFont.swift
//  NasaPhoto
//
//  Created by Sona on 14.03.24.
//

import Foundation
import UIKit

extension UIFont{
    
    func boldSfPro(size: Int) -> UIFont {
        if let ft = UIFont(name: "SF Pro Display Bold", size: CGFloat(size)) {
            return ft
        }
        return UIFont()
    }
    
    func regularSfPro(size: Int) -> UIFont {
        if let ft = UIFont(name: "SF Pro Display Regular", size: CGFloat(size)) {
            return ft
        }
        return UIFont()
    }
    
}

