//
//  NoteDetailViewController.swift
//  fundooNotes
//
//  Created by Yashom on 18/03/22.
//

import UIKit

enum NoteType {
    case new
    case update
}
class NoteDetailViewController: UIViewController,UITextViewDelegate {//, UITextViewDelegate {
    
    
    @IBOutlet weak var bottonBack: UIButton!
    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var note: Note?
    var noteType: NoteType = .new
    
//    private let titleString = "Title"
//    private let noteString = "Note"

   
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextView.delegate = self
        descriptionTextView.delegate = self
        
        titleTextView.text = "Title"
        titleTextView.textColor = UIColor.lightGray

        descriptionTextView.text = "Note"
        descriptionTextView.textColor = UIColor.lightGray
        setupNote()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard  note == nil else {
            return
        }
        print("textViewDidBeginEditing")
        if titleTextView.textColor == UIColor.lightGray   {
            titleTextView.text = nil
            titleTextView.textColor = UIColor.black
        }
        
        if descriptionTextView.textColor == UIColor.lightGray && titleTextView.text != nil {
            print("titleTextView.text.... \(titleTextView.text!)")
            descriptionTextView.text = nil
            descriptionTextView.textColor = UIColor.black
        }
        
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        guard note == nil else {
            return
        }

        print("textViewDidEndEditing")
        if titleTextView.text.isEmpty {
            titleTextView.text = "Title"
            titleTextView.textColor = UIColor.lightGray
        }
        
        if descriptionTextView.text.isEmpty {
            descriptionTextView.text = "Note"
            descriptionTextView.textColor = UIColor.lightGray
        }
    }
    
    private func setupNote() {
        
        
        guard let note = note else {
            return
        }
        
        
        titleTextView.text = note.title
        descriptionTextView.text = note.description
    }
    
    @IBAction func backBottonClicked(_ sender: UIButton) {
        
        let title = titleTextView.text!
        let description = descriptionTextView.text!
        
        
        //        navigationController?.popViewController(animated: true)
        
        switch noteType {
        case .new:
            if !title.isEmpty || !description.isEmpty {
                FirebaseNoteService().toStoreNoteData(title: title, description: description) { (status, errorMessage) in
                    if status == true {
                        self.dismiss(animated: true)
                    } else {
                        //show error
                        print("Erorr while adding new  note \(errorMessage ?? "null")")
                    }
                }
            }
        case .update:
            note?.title = title
            note?.description = description
            
            FirebaseNoteService().updateDocument(note: note!) { (status, errorMessage) in
                if status == true {
                    self.dismiss(animated: true)
                } else {
                    //show error
                    print("Erorr while updating the note \(errorMessage ?? "null")")
                }
            }
        }
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
//        })
    }
    

}

//learning comment

//        titleTextView.text = titleString
//        titleTextView.textColor = UIColor.lightGray
//
//        descriptionTextView.text = noteString
//        descriptionTextView.textColor = UIColor.lightGray

//        titleTextView.textColor = .black
//        descriptionTextView.textColor = .black
