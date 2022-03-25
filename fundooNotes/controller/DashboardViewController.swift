//
//  DashboardViewController.swift
//  fundooNotes
//
//  Created by Yashom on 17/03/22.
//

import UIKit

class DashboardViewController: UIViewController {
    var notes: [Note] = [
        Note(title: "faizan", description: "Shaikh"),
        Note(title: "danish", description: "khan"),
        Note(title: "salman", description: "Pathan")]
    
    @IBOutlet weak var collectionViewDashboard: UICollectionView!
    @IBOutlet weak var viewNavigationBar: UIView!
    @IBOutlet weak var viewTabBar: UIView!
    
    @IBOutlet weak var addNewNoteButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionViewDashboard.delegate = self
        collectionViewDashboard.dataSource = self
        
        collectionViewDashboard.contentInset.top = 20
        collectionViewDashboard.contentInset.bottom = 20
        
        collectionViewDashboard.register(UINib(nibName: "NotesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "NotesCollectionViewCellID")
        
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
