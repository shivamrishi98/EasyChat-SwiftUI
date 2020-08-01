//
//  ContentView.swift
//  EasyChat
//
//  Created by Shivam Rishi on 29/07/20.
//  Copyright © 2020 shivam. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseFirestore
struct ContentView: View {
    
    @State private var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
    
    var body: some View {
        
        VStack
            {
                
                if status
                {
                    NavigationView
                        {
                            HomeView().environmentObject(MainObservable())
                    }
                } else {
                    
                    NavigationView
                        {
                            LoginView()
                    }
                }
        }.onAppear {
            NotificationCenter.default.addObserver(forName: NSNotification.Name("statusChange"), object: nil, queue: .main) { (_) in
                
                let status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
                
                self.status = status
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


class MainObservable: ObservableObject
{
    @Published var recents = [Recent]()
    @Published var noRecents = false
    init() {
        
        
        let db = Firestore.firestore()
        let uid = Auth.auth().currentUser?.uid
        
        db.collection("users").document("\(uid!)").collection("recents").order(by: "date", descending: true).addSnapshotListener { (snap, error) in
            
            if error != nil
            {
                print(error!.localizedDescription)
                self.noRecents = true
                return
            }
            
            if snap!.isEmpty
            {
                self.noRecents = true
            }
            
            
            for i in snap!.documentChanges
            {
                
                if i.type == .added
                {
                    let id = i.document.documentID
                    let name = i.document.get("name") as! String
                    let profilePicUrl = i.document.get("profilePicUrl") as! String
                    let lastMsg = i.document.get("lastMsg") as! String
                    let timeStamp = i.document.get("date") as! Timestamp
                    
                    
                    let formattter = DateFormatter()
                    formattter.dateFormat = "dd/MM/yyyy"
                    let date = formattter.string(from: timeStamp.dateValue())
                    
                    formattter.dateFormat = "hh:mm a"
                    
                    let time = formattter.string(from: timeStamp.dateValue())
                    
                    self.recents.append(Recent(id: id, name: name, profilePicUrl: profilePicUrl, lastMsg: lastMsg, time: time, date: date, stamp: timeStamp.dateValue()))
                }
                
                if i.type == .modified
                {
                    
                    let id = i.document.documentID
               
                    let lastMsg = i.document.get("lastMsg") as! String
                    let timeStamp = i.document.get("date") as! Timestamp
                    
                    
                    let formattter = DateFormatter()
                    formattter.dateFormat = "dd/MM/yyyy"
                    let date = formattter.string(from: timeStamp.dateValue())
                    
                    formattter.dateFormat = "hh:mm a"
                    
                    let time = formattter.string(from: timeStamp.dateValue())
                    
                    for j in 0..<self.recents.count
                    {
                        if self.recents[j].id == id
                        {
                            self.recents[j].lastMsg = lastMsg
                             self.recents[j].time = time
                            self.recents[j].date = date
                            self.recents[j].stamp = timeStamp.dateValue()
                        }
                        
                        
                    }
                    
                    
                }
                
                
                
                
                
                
                
            }
            
            
            
            
        }
        
    }
}

struct Recent: Identifiable
{
    var id:String
    var name:String
    var profilePicUrl:String
    var lastMsg:String
    var time:String
    var date:String
    var stamp:Date
    
    
}





