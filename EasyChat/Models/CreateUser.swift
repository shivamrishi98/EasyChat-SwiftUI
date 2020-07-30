//
//  CreateUser.swift
//  EasyChat
//
//  Created by Shivam Rishi on 29/07/20.
//  Copyright © 2020 shivam. All rights reserved.
//

import Firebase
import FirebaseFirestore
import FirebaseStorage

func createUser(name: String, about:String,imageData: Data, completion: @escaping (Bool) -> Void)
{
    
    let db = Firestore.firestore()
    
    let storage = Storage.storage().reference()
    
    let uid = Auth.auth().currentUser?.uid
    
    storage.child("profilePics").child(uid!).putData(imageData, metadata: nil) { (data, error) in
        
        if error != nil
        {
            print(error!.localizedDescription)
            return
        }
        
        storage.child("profilePics").child(uid!).downloadURL { (url, error) in
            if error != nil
            {
                print(error!.localizedDescription)
                return
            }
            
            db.collection("users").document(uid!).setData(["uid":uid!,"name":name,"about":about,"profilePicUrl":"\(url!)"]) { (error) in
                if error != nil
                {
                    print(error!.localizedDescription)
                    return
                }
                
                completion(true)
                
                UserDefaults.standard.set(true, forKey: "status")
                
                UserDefaults.standard.set(name, forKey: "userName")
                
                UserDefaults.standard.set(uid, forKey: "uid")
                
                UserDefaults.standard.set(url!, forKey: "profilePicUrl")
                
                NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
                
            }
            
            
        }
        
        
        
    }
    
}



