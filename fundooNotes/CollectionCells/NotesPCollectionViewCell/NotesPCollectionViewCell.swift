//
//  NotesPCollectionViewCell.swift
//  fundooNotes
//
//  Created by Yashom on 26/03/22.
//

import UIKit

class NotesPCollectionViewCell: UICollectionViewCell {
    static let identifier = "NotesPCollectionViewCell"
    
    private let noteTitle: UILabel =  {
        let label = UILabel()
        label.text = "Title"
        label.textAlignment = .center
        return label
    }()
    
    private let noteDescription: UILabel =  {
        let label = UILabel()
        label.text = "Description"
        label.textAlignment = .center
        return label
    }()
    
    private var stackView: UIStackView = UIStackView()
    
    private func commonInit() {
        stackView = UIStackView(arrangedSubviews: [noteTitle, noteDescription])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)
        
        
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemRed
        contentView.addSubview(noteTitle)
        contentView.addSubview(noteDescription)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func  layoutSubviews() {
        super.layoutSubviews()
        noteDescription.frame = CGRect(x: 5, y: contentView.frame.size.height-50, width: contentView.frame.size.width-10, height: 50)
        
        noteTitle.frame = CGRect(x: 5, y: 0, width: contentView.frame.size.width-10, height: contentView.frame.size.height-50)
        
    }
    
}



