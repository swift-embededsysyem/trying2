//
//  extension.swift
//  newSocialApp
//
//  Created by akbar  Rizvi on 10/24/19.
//  Copyright © 2019 akbar  Rizvi. All rights reserved.
//

import Foundation
import SDWebImage
import UIKit

extension UIImageView {
    func loadImage(_ urlString: String?, onSuccess: ((UIImage) -> Void)? = nil) {
        self.image = UIImage()
        guard let string = urlString else { return }
        guard let url = URL(string: string) else { return }
        self.sd_setImage(with: url) { (image, error, type, url) in
            if onSuccess != nil, error == nil {
                onSuccess!(image!)
            }
        }
    }
    
}

/*
extension UIView {
    class func fromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}
*/
