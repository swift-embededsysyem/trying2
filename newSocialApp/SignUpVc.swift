//
//  ViewController.swift
//  newSocialApp
//
//  Created by akbar  Rizvi on 9/15/19.
//  Copyright © 2019 akbar  Rizvi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth



class SignUpVc: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var loginPop: UIButton!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userAge: UITextField!
    
    

    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func signupButton(_ sender: Any) {
        
        Auth.auth() .createUser(withEmail: emailTextField!.text!, password: passwordTextField!.text!) {(user,error)
            in
            if user != nil
            {
                self.performSegue(withIdentifier: "goToHome", sender: self)
                print("SignUp Sucessfull")
            }
            else {
                print("unSucessfull")
                // uiAlert
                let alert = UIAlertController(title:"wrong Information", message: nil, preferredStyle: .alert)
                let okButton = UIAlertAction(title: "ok", style: .default, handler: nil)
                alert.addAction(okButton)
                self.present(alert,animated: true,completion: nil)
                print("login Failed")
            }
            guard let userName = self.userName.text,!userName.isEmpty else {
                print("Email is Empty");return
            }
            guard let userAge = self.emailTextField.text,!userAge.isEmpty else {
                print("Age is required"); return
            }
            
            
            // upload image to firebase
            guard let profileImage = self.myImage.image else {return}
            
            guard let uploadData  =  profileImage.jpegData(compressionQuality:0.3) else {return}
            let filename = NSUUID().uuidString
            let storageRef = Storage.storage().reference().child("profile_images").child(filename)
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpg"
            storageRef.putData(uploadData, metadata: metadata, completion: { (metaData, error) in
                
                
                if let  error = error {
                    
                    // alert notification
                    
                    print("failed to Upload image",error.localizedDescription)
                    return
                }
                // retrieve download url
                
                storageRef.downloadURL(completion: { (downloadURL, error) in
                    guard let profileImageUrl = downloadURL?.absoluteString else {
                        print("DEBUG: Profile image url is nil")
                        return
                        
                    }
                    print(profileImageUrl)
                    
                    let userID = Auth.auth().currentUser?.uid
                    let userData = ["userName":userName,
                                    "userAge":userAge,"profileImageURL":profileImageUrl] as [String? : Any]
                    
                    
                    let ref = Database.database().reference()
                    
                    ref.child("users/\(userID ?? "")").setValue(userData)
                })
                
                
            })
            
        }
        
    }
    
    
    // camera
@IBAction func imagePicker(_ sender: Any) {
let imageController = UIImagePickerController()
imageController.sourceType = UIImagePickerController.SourceType.photoLibrary
imageController.delegate = self
imageController.allowsEditing = false
self.present(imageController,animated: true,completion:nil)
        
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        myImage.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
        
}
}
