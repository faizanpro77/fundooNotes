//
//  HomeController.swift
//  fundooNotes
//
//  Created by Yashom on 25/03/22.
//

import UIKit

class HomeController : UIViewController {
    
    //MARK: - Properties
    var delegate: HomeControllerDelegate?
    
    //MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureNavigationBar()
    }
    
    //MARK:- Handdlers
    @objc func handleMenuToggle(){
        delegate?.handleMenuToggle(forMenuOption: nil)
       // print("Toggle menu..")
    }
    
    
    
    //MARK:- Handlers
    func configureNavigationBar() {
//        navigationController?.navigationBar.barTintColor = .darkGray
//        navigationController?.navigationBar.barStyle = .black
        
        navigationItem.title = "Side Menu"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: self, action: #selector(handleMenuToggle))
        
        
        let uiBarBtn1 =  UIBarButtonItem(image: UIImage(systemName: "person.circle"), style: .plain, target: self, action: #selector(handleMenuToggle))
        
        let uiBarBtn2 =  UIBarButtonItem(image: UIImage(systemName: "square.grid.2x2"), style: .plain, target: self, action: #selector(handleMenuToggle))
        
        navigationItem.rightBarButtonItems = [uiBarBtn1,uiBarBtn2]

    }
}
