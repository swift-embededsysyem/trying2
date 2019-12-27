//
//  UserCollecviewCollectionViewCell.swift
//  newSocialApp
//
//  Created by akbar  Rizvi on 12/21/19.
//  Copyright © 2019 akbar  Rizvi. All rights reserved.
//

import UIKit
import SDWebImage
// user did set method to get user objects such as objects such as user age , username and their picture(Avator) string by sdweb.
class UserCollecviewCollectionViewCell: UICollectionViewCell {
    var user:User!
     var controller: HomeVc!
    @IBOutlet weak var avator: UIImageView!
    func loadUser(_ user: User){
        self.user = user
     //   self.avator.loadImage(user.profileImageURL)
       // self.avator.loadImage(user.profileImageURL)
        print(user.profileImageURL as Any)
     
        
   //     self.avator.loadImage(user.profileImageURL) { (image) in
       //      user.profileImageURL = image
            
    //    }
        guard let profileImageUrl = user.profileImageURL else { return }
        self.avator.loadImage(profileImageUrl)
          self.controller.collectionView.reloadData()
        print(profileImageUrl)
        
    }
}
