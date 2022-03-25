//
//  NoteDetailViewController.swift
//  fundooNotes
//
//  Created by Yashom on 18/03/22.
//

import UIKit

class NoteDetailViewController: UIViewController {//, UITextViewDelegate {

   
    @IBOutlet weak var bottonBack: UIButton!
    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var note: Note?
    
    private let titleString = "Title"
    private let noteString = "Note"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNote()
    }
    
    private func setupNote() {
//        titleTextView.text = titleString
//        titleTextView.textColor = UIColor.lightGray
//        
//        descriptionTextView.text = noteString
//        descriptionTextView.textColor = UIColor.lightGray
        
        guard let note = note else {
            return
        }
//        titleTextView.textColor = .black
//        descriptionTextView.textColor = .black
        
        titleTextView.text = note.title
        descriptionTextView.text = note.description
    }
    
    @IBAction func backBottonClicked(_ sender: UIButton) {
        dismiss(animated: true)
    }
    /*
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView == titleTextView {
            if textView.text.isEmpty {
                textView.text = titleString
                textView.textColor = UIColor.lightGray
            } else {
                textView.textColor = .black
            }
        
        } else {
            if textView.text.isEmpty {
                textView.text = noteString
                textView.textColor = UIColor.lightGray
            } else {
                textView.textColor = .black
            }
        }
    }
    */
    
}
