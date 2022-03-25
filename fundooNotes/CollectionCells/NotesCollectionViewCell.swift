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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = 2
        layer.cornerRadius = 10
        
        labelTitle.textColor = .red
        labelDescription.textColor = .green
        
        backgroundColor = .lightText
    }
    
    func configureCell(note: Note) {
        labelTitle.text = note.title
        labelDescription.text = note.description
    }
}
