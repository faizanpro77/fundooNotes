//
//  SignupViewController.swift
//  fundooNotes
//
//  Created by Yashom on 11/03/22.
//

import UIKit
import FirebaseAuth


class SignupViewController: UITableViewController {
    
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPasswod: UITextField!
    @IBOutlet weak var txtConPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let  tapGasture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        //imgProfile.isUserInteractionEnabled = true
        imgProfile.addGestureRecognizer(tapGasture)
    }
    
    @objc
    func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        openGallery()
    }
    
    
    @IBAction func btnSignupClicked(_ sender: UIButton) {
        let imgSystem = UIImage(systemName: "person.crop.circle.badge.plus.fill")
        if imgProfile.image?.pngData() != imgSystem?.pngData() {
            //profile image selected
            if let email = txtEmail.text, let password = txtPasswod.text, let username = txtUsername.text,  let conPassword = txtConPassword.text{
                if username == ""{
                    print("please enter user name")
                }else if !email.validateEmailId(){
                    openAlert(title: "Alert", message: "Please enter valid email", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in}])
                }else if !password.validatePassword(){
                    print("password is not valid")
                } else {
                    if conPassword == ""{
                        print("Please confirm password")
                    }else{
                        if password == conPassword{
                            //Navigation code
                            print("navigation code Yeah")
                            firbaseAuthEmailPassword()
                        }else{
                            print("password does not matched")
                        }
                    }
                }
            }else{
                print("please check your details")
            }
        }else{
            print("Please select profile picture")
        }
        
    }
    
    func firbaseAuthEmailPassword() {
        
        Auth.auth().createUser(withEmail: txtEmail.text!, password: txtPasswod.text!) {  authResult, error in
            if error != nil {
                print(error?.localizedDescription ?? "Exception")
            }else {
                print("LOGIN - \(String(describing: authResult?.user.uid))")
//                if authResult?.user.uid != nil{
//
//                }else{
//                    self.navigationController?.popViewController(animated: true)
//                }
            }
        }
    }
    
    
    @IBAction func btnLoginClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //to fit UI in small device instead of scroll
    //    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        return UIScreen.main.bounds.height
    //    }
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let tableViewHeight = self.tableView.frame.height
        let contentHeight = self.tableView.contentSize.height
        
        let centeringInset = (tableViewHeight - contentHeight) / 2.0
        let topInset = max(centeringInset, 0.0)
        
        self.tableView.contentInset = UIEdgeInsets(top: topInset, left: 0.0, bottom: 0.0, right: 0.0)
    }
    
}

extension SignupViewController: UINavigationControllerDelegate,UIImagePickerControllerDelegate{
    
    func openGallery() {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            let picker = UIImagePickerController()
            picker .delegate = self
            picker.sourceType = .savedPhotosAlbum
            present(picker, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let img = info[.originalImage] as? UIImage{
            imgProfile.image = img
        }
        dismiss(animated: true)
        
    }
}
