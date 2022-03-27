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
        
        labelTitle.textColor = .black
        labelDescription.textColor = .gray
        
        labelTitle.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        
    }
    
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
