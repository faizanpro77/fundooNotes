//
//  HomeController.swift
//  fundooNotes
//
//  Created by Yashom on 25/03/22.


// this controller not in use

import UIKit

class HomeController : UIViewController {
    
    private var collectionView: UICollectionView?

    
    //MARK: - Properties
    var delegate: HomeControllerDelegate?
    
    //MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureNavigationBar()
        
        configureCollectionView()
    }
    
    private func configureCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 4
        layout.itemSize = CGSize(width: (view.frame.size.width/2) - 4, height: view.frame.size.width/2)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = collectionView else {
            return
        }
        
        collectionView.register(NotesPCollectionViewCell.self, forCellWithReuseIdentifier: NotesPCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
        
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
        
//        navigationItem.title = "Side Menu"
//        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: self, action: #selector(handleMenuToggle))
        
        let menuButton =  UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: self, action: #selector(handleMenuToggle))
        
        let searchButton =  UIBarButtonItem(title: "Search your Notes", menu: nil)
        
        navigationItem.leftBarButtonItems = [menuButton,searchButton]
        
        let uiBarBtn1 =  UIBarButtonItem(image: UIImage(systemName: "person.circle"), style: .plain, target: self, action: #selector(handleMenuToggle))
        
        let uiBarBtn2 =  UIBarButtonItem(image: UIImage(systemName: "square.grid.2x2"), style: .plain, target: self, action: #selector(handleMenuToggle))
        
        navigationItem.rightBarButtonItems = [uiBarBtn1,uiBarBtn2]

    }
}

extension HomeController:  UICollectionViewDataSource {
 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NotesPCollectionViewCell.identifier, for: indexPath)
        return cell
    }
}

extension HomeController:UICollectionViewDelegate {
    
}
