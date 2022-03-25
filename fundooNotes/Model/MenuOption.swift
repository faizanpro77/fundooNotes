//
//  MenuOption.swift
//  fundooNotes
//
//  Created by Yashom on 25/03/22.
//

import UIKit

enum MenuOption: Int, CustomStringConvertible, CaseIterable {
    
    
    case Notes
    case Reminders
    case Archive
    case Deleted
    case Settings
    case Help
    
    var description: String {
        switch self {
        case .Notes: return "Notes"
        case .Reminders: return "Reminders"
        case .Archive: return "Archive"
        case .Deleted: return "Deleted"
        case .Settings: return "Settings"
        case .Help: return "Help & feedback"
        
        }
    }
    
    var image: UIImage {
        switch self {
        case .Notes: return UIImage(systemName: "lightbulb") ?? UIImage()
        case .Reminders: return UIImage(systemName: "bell") ?? UIImage()
        case .Archive: return UIImage(systemName: "archivebox") ?? UIImage()
        case .Deleted: return UIImage(systemName: "trash") ?? UIImage()
        case .Settings: return UIImage(systemName: "gearshape") ?? UIImage()
        case .Help: return UIImage(systemName: "questionmark.circle") ?? UIImage()
        }
    }
    
}
