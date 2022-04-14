//
//  FirebaseNoteService.swift
//  fundooNotes
//
//  Created by Yashom on 28/03/22.
//

//all notes crud operation query here

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseDatabase

class FirebaseNoteService {
    
    //to add an note
    func toStoreNoteData(title: String, description: String, completion: @escaping (Bool, String?) -> ()) {
        
        print("user UID is ===============> \(String(describing: Auth.auth().currentUser?.uid))")
        guard let userID = Auth.auth().currentUser?.uid else {
            return
        }
        let db = Firestore.firestore()
        
        let document = db.collection("notesData").document(userID).collection("notes").document()
        print("document Id ======> \(document.documentID)")
        document.setData(["title": title, "description": description,"trash": false]) { error in
            if error != nil {
                print("error in saving data ")
                completion(false, error?.localizedDescription)
            } else {
                completion(true, nil)
                print("successfully saved")
            }
        }
    }

    
    //to get note data
    func toGetNotesData(completion: @escaping ([Note]) -> ()) {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        let db = Firestore.firestore()
        let document = db.collection("notesData").document(userId).collection("notes")
        
        document.getDocuments { (snapshot, error) in
            if error == nil && snapshot != nil {
                var notesArray: [Note] = []
                
                for document in snapshot!.documents {
                    let docId = document.documentID

                    var documentData = document.data()
                    documentData["id"] = docId
                    
                    let note = Note(
                        title: documentData["title"] as! String,
                        description: documentData["description"] as! String,
                        id: documentData["id"] as! String
                    )
                    
                    notesArray.append(note)
                    print("documentData======>",documentData,"======>",docId)
                  //  return documentData
                }
                completion(notesArray)
            } else {
                print(error?.localizedDescription)
            }
        }
        
    }

    //for update note data
    func updateDocument(note: Note, completion: @escaping (Bool, String?) -> ()) {
        
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        
        let db = Firestore.firestore()
        let document = db.collection("notesData").document(userId).collection("notes")
        document.document(note.id).setData(["title": note.title, "description": note.description], merge: true) { (error) in
            if error != nil {
                //we have an error
                completion(false, error?.localizedDescription)
                print("firebase error",error!)
                
            } else {
                //update was sucessful
                completion(true, nil)
                print("update sucessful")
            }
        }
    }
    
    //update trash notes
    
    func updateTrashNotes() {
        
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        let db = Firestore.firestore()
        let document = db.collection("notesData").document(userId).collection("notes")
        document.document("documentId").delete { (error) in
            if error != nil {
                //we have an error
            } else {
                //delete was successful
            }
        }
    }
}

//delete 20:00 minut
//    // Updating a specific document ID
//    db.collection("wine")
//        .document("stoneypath-cab-2017")
//        .setData(["year":2017,
//                  "type":"cab",
//                  "label":"Stoney Path"], merge:true)
    
