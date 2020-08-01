//
//  messages.swift
//  EasyChat
//
//  Created by Shivam Rishi on 01/08/20.
//  Copyright © 2020 shivam. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore
import SwiftUI




struct Msg:Identifiable
{
    var id:String
    var msg:String
    var user:String
}



struct ChatBubble: Shape
{
    var msg:Bool
    
    func path(in rect: CGRect) -> Path {
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft,.topRight, msg ? .bottomLeft: .bottomRight], cornerRadii: CGSize(width: 16, height: 16))
        
        return Path(path.cgPath)
    }
    
}


func sendMsg(uid:String,pic:String,name:String,msg:String,date:Date)
{
    
    let db = Firestore.firestore()
    
    let myUid = Auth.auth().currentUser?.uid
    
    db.collection("users").document(uid).collection("recents").document(myUid!).getDocument { (snap, error) in
        if error != nil
        {
            print(error!.localizedDescription)
            setRecents(uid: uid, name: name, msg: msg, pic: pic, date: date)
            return
        }
        
        if !snap!.exists
        {
            
            setRecents(uid: uid, name: name, msg: msg, pic: pic, date: date)
            
            
        } else {
            updateRecents(uid: uid, msg: msg, date: date)
        }
        
        
        
    }
    
    updateMsgDB(uid: uid, msg: msg, date: date)
}

func setRecents(uid:String,name:String,msg:String,pic:String,date:Date)
{
    let db = Firestore.firestore()
    let myUid = Auth.auth().currentUser?.uid
    
    let myName = UserDefaults.standard.value(forKey: "userName") as! String
    let myPic = UserDefaults.standard.value(forKey: "profilePicUrl") as! String
    db.collection("users").document(uid).collection("recents").document(myUid!).setData(["name":myName,"profilePicUrl":myPic,"lastMsg":msg,"date":date]) { (error) in
        if error != nil
        {
            print(error!.localizedDescription)
            return
        }
        
    }
    
    db.collection("users").document(myUid!).collection("recents").document(uid).setData(["name":name,"profilePicUrl":pic,"lastMsg":msg,"date":date]) { (error) in
        if error != nil
        {
            print(error!.localizedDescription)
            return
        }
        
    }
    
    
    
}


func updateRecents(uid:String,msg:String,date:Date)
{
    let db = Firestore.firestore()
    let myUid = Auth.auth().currentUser?.uid
    
    db.collection("users").document(uid).collection("recents").document(myUid!).updateData(["lastMsg":msg,"date":date]) { (error) in
        if error != nil
        {
            print(error!.localizedDescription)
            return
        }
    }
    
    db.collection("users").document(myUid!).collection("recents").document(uid).updateData(["lastMsg":msg,"date":date]) { (error) in
        if error != nil
        {
            print(error!.localizedDescription)
            return
        }
    }
}

func updateMsgDB(uid:String,msg:String,date:Date)
{
    let db = Firestore.firestore()
    let myUid = Auth.auth().currentUser?.uid
    
    db.collection("msgs").document(uid).collection(myUid!).document().setData(["userUID":myUid!,"msg":msg,"date":date]) { (error) in
        if error != nil
        {
            print(error!.localizedDescription)
            return
        }
    }
    
    db.collection("msgs").document(myUid!).collection(uid).document().setData(["userUID":myUid!,"msg":msg,"date":date]) { (error) in
        if error != nil
        {
            print(error!.localizedDescription)
            return
        }
    }
    
}
