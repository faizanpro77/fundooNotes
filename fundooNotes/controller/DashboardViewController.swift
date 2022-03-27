//
//  DashboardViewController.swift
//  fundooNotes
//
//  Created by Yashom on 17/03/22.
//

import UIKit

class DashboardViewController: UIViewController {
    
    var delegate: HomeControllerDelegate?
    
    var notes: [Note] = [
        Note(title: "faizan", description: "Shaikh"),
        Note(title: "danish", description: "khan"),
        Note(title: "salman", description: "Pathan")]
    
    @IBOutlet weak var collectionViewDashboard: UICollectionView!
    @IBOutlet weak var viewNavigationBar: UIView!
    @IBOutlet weak var viewTabBar: UIView!
    @IBOutlet weak var addNewNoteButton: UIButton!
    @IBOutlet weak var showProfileButton: UIButton!
    @IBOutlet weak var gridListButton: UIButton!
    @IBOutlet weak var searchButton: UITextField!
    @IBOutlet weak var menuButton: UIButton!
    
    
    private var overlayView: UIView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionViewDashboard.delegate = self
        collectionViewDashboard.dataSource = self
        
        collectionViewDashboard.contentInset.top = 20
        collectionViewDashboard.contentInset.bottom = 20
        
        collectionViewDashboard.register(UINib(nibName: "NotesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "NotesCollectionViewCellID")
        
        setUpUI()
        
    }
    
    
    
    private func setUpUI() {
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
        self.present(noteDetailController, animated: true, completion: nil)
    }
    
    
}



struct Note {
    var title: String
    var description: String
}
