//
//  DashboardViewController.swift
//  fundooNotes
//
//  Created by Yashom on 17/03/22.
//

import UIKit
import FirebaseAuth


class DashboardViewController: UIViewController {
    
    var delegate: HomeControllerDelegate?
    
    var notes: [Note] = [
        Note(title: "Loading", description: "...", id: "1")]
    
    @IBOutlet weak var collectionViewDashboard: UICollectionView!
    @IBOutlet weak var viewNavigationBar: UIView!
    @IBOutlet weak var viewTabBar: UIView!
    @IBOutlet weak var addNewNoteButton: UIButton!
    @IBOutlet weak var showProfileButton: UIButton!
    @IBOutlet weak var gridListButton: UIButton!
    @IBOutlet weak var searchButton: UITextField!
    @IBOutlet weak var menuButton: UIButton!
    
    
    private var overlayView: UIView?
    let checkFirebaseLogin = Auth.auth().currentUser?.uid
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionViewDashboard.delegate = self
        collectionViewDashboard.dataSource = self
        setUpUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getNotes()
    }
    
    func getNotes() {
        FirebaseNoteService().toGetNotesData { (notesData) in
            self.notes =  notesData
            self.collectionViewDashboard.reloadData()
        }
    }
        
    
    
    
    
    private func setUpUI() {
        
        collectionViewDashboard.contentInset.top = 20
        collectionViewDashboard.contentInset.bottom = 20
        
        collectionViewDashboard.register(UINib(nibName: "NotesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "NotesCollectionViewCellID")
        
        
        addNewNoteButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        addNewNoteButton.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        addNewNoteButton.layer.shadowOpacity = 1.0
        addNewNoteButton.layer.shadowRadius = 5
        addNewNoteButton.layer.masksToBounds = false
        addNewNoteButton.layer.cornerRadius = 15
        
        showProfileButton.layer.cornerRadius = showProfileButton.frame.width/2
        viewNavigationBar.layer.cornerRadius = viewNavigationBar.frame.height/2
    }
    
    
    @IBAction func showProfile(_ sender: UIButton) {
        print("==========> inside show profile")
        if checkFirebaseLogin != nil {
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
                print("Logout Successful From Firebase")
                goToLoginScreen()
            } catch let err {
                print("Firebase error--->",err)
            }
        }
        //        goToLoginScreen()
        
    }
    
    //method for navigate controller to home screen
    func goToLoginScreen() {
        let loginTableViewController = storyboard?.instantiateViewController(withIdentifier: Constants.StoryBoard.LoginTableViewController) as? LoginTableViewController
        
        let nav = UINavigationController(rootViewController: loginTableViewController!)
        view.window?.rootViewController = nav
        view.window?.makeKeyAndVisible()
        
        
    }
    
    @IBAction func toggleGridList(_ sender: UIButton) {
    }
    
    
    @IBAction func searchNote(_ sender: UITextField) {
    }
    
    
    
    @IBAction func showMenu(_ sender: UIButton) {
        delegate?.handleMenuToggle(forMenuOption: nil)
        
        guard let overlayView = overlayView else {
            overlayView = UIView()
            overlayView?.backgroundColor = UIColor.black.withAlphaComponent(0.2)
            view.addSubview(overlayView!)
            overlayView?.frame = view.bounds
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
            overlayView?.addGestureRecognizer(tap)
            
            return
        }
        overlayView.isHidden = !overlayView.isHidden
        
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        showMenu(UIButton())
    }
    
    
    @IBAction func addNewNote(_ sender: UIButton) {
        
        let noteDetailController = self.storyboard?.instantiateViewController(withIdentifier: "NoteDetailViewController") as! NoteDetailViewController
        noteDetailController.modalPresentationStyle = .fullScreen
        self.present(noteDetailController, animated: true, completion: nil)
        
    }
}
    


extension DashboardViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        notes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NotesCollectionViewCellID", for: indexPath) as! NotesCollectionViewCell
        cell.configureCell(note: notes[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = ((collectionView.frame.width - 15) / 2) // 15 because of paddings
        print("cell width : \(width)")
        
        return CGSize(width: width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let noteDetailController = self.storyboard?.instantiateViewController(withIdentifier: "NoteDetailViewController") as! NoteDetailViewController
        noteDetailController.modalPresentationStyle = .fullScreen
        noteDetailController.note = notes[indexPath.item]
        noteDetailController.noteType = .update
        self.present(noteDetailController, animated: true, completion: nil)
    }
    
    
    
}




//                navigationController?.popViewController(animated: true)
//                self.dismiss(animated: true, completion: nil)
//               navigationController?.pushViewController(noteDetailController, animated: true)
