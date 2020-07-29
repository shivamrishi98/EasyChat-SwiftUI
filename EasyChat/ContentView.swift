//
//  ContentView.swift
//  EasyChat
//
//  Created by Shivam Rishi on 29/07/20.
//  Copyright © 2020 shivam. All rights reserved.
//

import SwiftUI
import Firebase

struct ContentView: View {
    
    @State private var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
    
    var body: some View {
        
        VStack
            {
                
                if status
                {
                    HomeView()
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





