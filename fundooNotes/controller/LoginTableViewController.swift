//
//  LoginTableViewController.swift
//  fundooNotes
//
//  Created by Yashom on 09/03/22.
//

import UIKit
import FacebookLogin
import FBSDKLoginKit
import Firebase
import GoogleSignIn
import FirebaseAuth

class LoginTableViewController: UITableViewController {
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var loginButton: FBLoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        facebookLogin()
        googleLogin()
        firbaseAuthEmailPassword()
        
    }
    
    
    @IBAction func btnGoogleLogin(_ sender: UIButton) {
        
        print("Google btn clicked.....")
        GIDSignIn.sharedInstance.signIn(with: GIDConfiguration.init(clientID: "879786320034-391ge2p87gba4br27979qgqniol8v4tt.apps.googleusercontent.com"), presenting: self) { googleUser, err in
            print("******************* \(String(describing: googleUser))!")
            guard let googleUser = googleUser else {
                return
            }
            print(googleUser.profile?.email ?? "")
        }
    }
    
    
    
    @IBAction func btnLoginClicked(_ sender: UIButton) {
        emailPasswordValidation()
        //txtEmail.text!.demo()
        
    }
    
    
    @IBAction func btnForgotPswd(_ sender: UIButton) {
        Auth.auth().sendPasswordReset(withEmail: txtEmail.text!) { (error) in
            if error != nil {
                print("Sent ......")
            }else {
                print("Failed - \(String(describing: error?.localizedDescription))")
            }
        }
    }
    
    func firbaseAuthEmailPassword() {
        
        Auth.auth().signIn(withEmail: txtEmail.text!, password: txtPassword.text!) {  authResult, error in
            if error != nil {
                print(error?.localizedDescription ?? "Exception")
            } else {
                print("LOGIN - \(String(describing: authResult?.user.uid))")
                let token = authResult?.user.uid
                UserManager.shared.saveGoogleToken(token: token)
                self.transitionToHome()
            }
        }
    }
    
    @IBAction func btnSignupClicked(_ sender: UIButton) {
        if let signupVC = self.storyboard?.instantiateViewController(identifier: "SignupViewController") as? SignupViewController{
            self.navigationController?.pushViewController(signupVC, animated: true)
        }
    }
    
    func facebookLogin() {
        _ = FBLoginButton()
        if let token = AccessToken.current,
           !token.isExpired {
            // User is logged in, do work such as go to next view controller.
            if let token = AccessToken.current,
               !token.isExpired {
                // User is logged in, do work such as go to next view controller.
                let token = token.tokenString
                
                let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields": "id, email, first_name, last_name, picture, short_name, name, middle_name, name_format,age_range"], tokenString: token, version: nil, httpMethod: .get)
                request.start { (connection, result, error) in
                    print("\(String(describing: result))")
                }
            }else{
                loginButton.permissions = ["public_profile", "email"]
                loginButton.delegate = self
            }
        }
    }
    
    func googleLogin() {
        if GIDSignIn.sharedInstance.hasPreviousSignIn(){
            print("Already Login")
        }
    }
    
    //method for navigate controller to home screen
    func transitionToHome() {
        //        let homeViewController = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as? HomeViewController
        view.window?.rootViewController = ContainerController()
        view.window?.makeKeyAndVisible()
        
    }
}

extension LoginTableViewController{
    fileprivate func emailPasswordValidation() {
        if let email = txtEmail.text, let password = txtPassword.text{
            if !email.validateEmailId(){
                openAlert(title: "Alert", message: "Email address not found", alertStyle: .alert, actionTitles: ["Okey"], actionStyles: [.default], actions: [{_ in
                    print("Okay clicked!")
                }])
            } else if !password.validatePassword() {
                openAlert(title: "Alert", message: "Please enter valid password", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in
                    print("Okay clicked!")
                }])
            } else {
                //Navigation - Home Screen
                firbaseAuthEmailPassword()
                
            }
        } else {
            openAlert(title: "Alert", message: "Please add details", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in
                print("Okay clicked!")
            }])
            
            
        }
    }
}




extension LoginTableViewController {
    
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
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        nil
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        nil
    }
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        0
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        0
    }
    
}


extension LoginTableViewController: LoginButtonDelegate {
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        
        let token = result?.token?.tokenString
        let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields": "email,name,picture"], tokenString: token, version: nil, httpMethod: .get)
        request.start { (connection, result, error) in
        }
    }
    
    func loginButtonWillLogin(_ loginButton: FBLoginButton) -> Bool {
        //  print("Fazzy logs: loginButtonWillLogin func called")
        return true
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("Fazzy logs: loginButtonDidLogOut func called")
    }
}


