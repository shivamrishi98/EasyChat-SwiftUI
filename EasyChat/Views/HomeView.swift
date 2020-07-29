//
//  HomeView.swift
//  EasyChat
//
//  Created by Shivam Rishi on 29/07/20.
//  Copyright © 2020 shivam. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseStorage
struct HomeView: View
{
    
    
    var body: some View
    {
        VStack
            {
                Text("Welcome \(UserDefaults.standard.value(forKey: "userName") as! String)")
                
                Button(action: {
                    
                    try! Auth.auth().signOut()
                    
                    
                    UserDefaults.standard.set(false, forKey: "status")
                    
                    NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
                    
                    
                })
                {
                    Text("Logout")
                }
        }
        
        
    }
    
    
    
    
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
