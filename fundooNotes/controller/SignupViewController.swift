
//  SignupViewController.swift
//  fundooNotes
//  Created by Yashom on 11/03/22.


import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore



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
        //create clean version of data
        let userName = txtUsername.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let email = txtEmail.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = txtPasswod.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        print("email =======> \(email)")
        print("password =======> \(password)")

        //create user
        Auth.auth().createUser(withEmail: email, password: password) { [self] (result, err) in
            //check for errors
            if err != nil {
                //there was an error creating the user
                self.showError("Error creating user")
                print("Error creating user")
            } else {
                //user are created sucessfully now stored first name and last name
                let db = Firestore.firestore()
                
                let uid = result!.user.uid
                db.collection("users").document(uid).setData(["username": userName, "email": email , "uid": uid]) { (error) in
                    if error != nil {
                        //show error message
                        self.showError("Error saving user data")
                        print("Error saving user data")
                    } else {
                        UserManager.shared.saveGoogleToken(token: uid)
                        self.transitionToHome()
                    }
                }    
                self.dismiss(animated: true, completion: nil)
                //transition to home screen
            }
        }
        
    }
    
    
    //method for navigate controller to home screen
    func transitionToHome() {
//        let homeViewController = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as? HomeViewController
        view.window?.rootViewController = ContainerController()
        view.window?.makeKeyAndVisible()
        
    }
    
    
    func showError(_ message: String) {
//        errorLabel.text = message
//        errorLabel.alpha = 1
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
