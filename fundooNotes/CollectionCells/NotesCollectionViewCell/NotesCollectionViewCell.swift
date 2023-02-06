//
//  NotesCollectionViewCell.swift
//  fundooNotes
//
//  Created by Yashom on 17/03/22.
//

import UIKit

class NotesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    
    //When an object receives an awakeFromNib message, it is guaranteed to have all its outlet and action connections already established.
    //The commonly recommended place to do custom initialization for custom views
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        labelTitle.textColor = .black
        labelDescription.textColor = .gray
        
        labelTitle.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        
    }
    
    //any time the frame changes layoutSubviews() is called
    //Subclasses can override this method as needed to perform more precise layout of their subviews. You should override this method only if the autoresizing and constraint-based behaviors
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = 2
        layer.cornerRadius = 10
        
        backgroundColor = .lightText
    }
    
    func configureCell(note: Note) {
        labelTitle.text = note.title
        labelDescription.text = note.description
    }
}
