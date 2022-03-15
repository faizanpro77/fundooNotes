//
//  LoginTableViewController.swift
//  fundooNotes
//
//  Created by Yashom on 09/03/22.
//

import UIKit
import FacebookLogin
import FBSDKLoginKit

class LoginTableViewController: UITableViewController {
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var loginButton: FBLoginButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         _ = FBLoginButton()


        
//        if let token = AccessToken.current,
//           !token.isExpired {
//            // User is logged in, do work such as go to next view controller.
//
//        } else {
//            loginButton.permissions = ["public_profile", "email"]
//            loginButton.delegate = self
//        }
//    }
   
        if let token = AccessToken.current,
           !token.isExpired {
            // User is logged in, do work such as go to next view controller.
            if let token = AccessToken.current,
                      !token.isExpired {
                       // User is logged in, do work such as go to next view controller.
                       let token = token.tokenString
                       
                       let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields": "id, email, first_name, last_name, picture, short_name, name, middle_name, name_format,age_range"], tokenString: token, version: nil, httpMethod: .get)
                       request.start { (connection, result, error) in
                           print("\(result)")
                       }
                   }else{
                       loginButton.permissions = ["public_profile", "email"]
                       loginButton.delegate = self
                   }
            
        } else {
            loginButton.permissions = ["public_profile", "email"]
            loginButton.delegate = self
        }
    }
        
    
    @IBAction func btnLoginClicked(_ sender: UIButton) {
        emailPasswordValidation()
        //txtEmail.text!.demo()
    }
    
    @IBAction func btnSignupClicked(_ sender: UIButton) {
        if let signupVC = self.storyboard?.instantiateViewController(identifier: "SignupViewController") as? SignupViewController{
            self.navigationController?.pushViewController(signupVC, animated: true)
    }
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
            print("result----> \(result)")
        }
        
        print("Fazzy logs: loginButton(_ loginButton func called")
        print("Fazzy logs: error \(error?.localizedDescription ?? "NULL")")
        //print("Fazzy logs: result \(result)")
    }
    
    func loginButtonWillLogin(_ loginButton: FBLoginButton) -> Bool {
        print("Fazzy logs: loginButtonWillLogin func called")
        return true
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("Fazzy logs: loginButtonDidLogOut func called")
    }
}