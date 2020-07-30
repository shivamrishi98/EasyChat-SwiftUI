//
//  function.swift
//  EasyChat
//
//  Created by Shivam Rishi on 29/07/20.
//  Copyright © 2020 shivam. All rights reserved.
//

import Firebase
import FirebaseFirestore
import FirebaseStorage


public func checkUser(completion: @escaping (Bool,String,String,String) -> Void)
{
    let db  = Firestore.firestore()
    
    db.collection("users").getDocuments { (snap,error ) in
        
        if error != nil
        {
            print(error!.localizedDescription)
            return
        }
        
        for i in snap!.documents
        {
            
            if i.documentID == Auth.auth().currentUser?.uid
            {
                completion(true,i.get("name") as! String,i.documentID,i.get("profilePicUrl") as! String)
            }
            
            
        }
        
        completion(false,"","","")
        
        
        
    }
}

