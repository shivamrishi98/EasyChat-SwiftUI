//
//  GetAllUsers.swift
//  EasyChat
//
//  Created by Shivam Rishi on 30/07/20.
//  Copyright © 2020 shivam. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore
class getUsers:ObservableObject
{
    @Published var users = [User]()
    
    init() {
        let db  = Firestore.firestore()
        
        
        
        db.collection("users").getDocuments { (snap, error) in
            if error != nil
            {
                print(error!.localizedDescription)
                return
            }
            
            for i in snap!.documents
            {
                let id = i.documentID
                let name = i.get("name") as! String
                let about = i.get("about") as! String
                let profilePicUrl = i.get("profilePicUrl") as! String
                
                if id != UserDefaults.standard.value(forKey: "uid") as! String
                {
                    self.users.append(User(id: id, name: name, about: about, profilePicUrl: profilePicUrl))
                }
            }
        }
        
    }
    
    
}


struct User:Identifiable
{
    var id:String
    var name:String
    var about:String
    var profilePicUrl:String
}
