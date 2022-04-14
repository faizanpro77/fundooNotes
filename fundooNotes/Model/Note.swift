//
//  Note.swift
//  fundooNotes
//
//  Created by Yashom on 28/03/22.
//

import Foundation

struct Note: Codable {
    
    var title: String
    var description: String
    var id: String
    
    var dictionary:[String:Any] {
           return [
               "name":title,
               "description":description
           ]
       }   
}


