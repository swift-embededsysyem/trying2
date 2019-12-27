//
//  signupViewController.swift
//  newSocialApp
//
//  Created by akbar  Rizvi on 10/13/19.
//  Copyright © 2019 akbar  Rizvi. All rights reserved.
//


//  I have to use  find user method to bring the users to display on the screen.... 
import UIKit
import Firebase
import SDWebImage


class HomeVc: UIViewController {
    var users: [User] = []

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         fetchCurrentUserData()
        collectionView.delegate = self
        collectionView.dataSource = self
       
        
        
        
    }
    func fetchCurrentUserData() {
        
        guard  let currentUid = Auth.auth().currentUser?.uid else {return}
        
     //   if currentUid != currentUid {
        
        
        // I was stuck my 6 days becuause of not going
       // into the right root of the data base
       
           Database.database().reference().child("users").observeSingleEvent(of: DataEventType.value, with: { (snapshot) in guard let dictionary = snapshot.value as? Dictionary<String , AnyObject> else {return}
                let uid = snapshot.key
                let user = User(uid:uid , dictionary: dictionary)
                self.users.append(user)
                self.collectionView.reloadData()
                
                
                print(snapshot.value as Any)
                
                
                print(dictionary)
                
            }) { (error) in
                print(error.localizedDescription)
            }
        
        }
       /* Database.database().reference().child("users").child(currentUid).observe(DataEventType.value, with: { (snapshot) in
                guard let dictionary = snapshot.value as? Dictionary<String , AnyObject> else {return}
                let uid = snapshot.key
                let user = User(uid:uid , dictionary: dictionary)
                self.users.append(user)
                self.collectionView.reloadData()
                
                
                print(snapshot.value as Any)
                
                
                print(dictionary)
                
            }) { (error) in
                print(error.localizedDescription)
            }
        } else {
            print("error")
        }
       
*/
        
    
    // logOut user
    @IBAction func logOutButton(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            self.dismiss(animated: true, completion: nil)
        }
        catch let error {
            print(error)
        }
    }
    
    

}
extension HomeVc: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.users.count
        //return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  "UserCollectionViewCell", for: indexPath) as! UserCollecviewCollectionViewCell
       // cell.avator.image = UIImage(named: "dummy")
        let user = users[indexPath.item]
        cell.controller = self
       cell.loadUser(user)
        
      // cell.avator.image = UIImage(named: "hazrat-ali-quotes-about-life")
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width/3 - 2, height: view.frame.size.width/3)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
}
