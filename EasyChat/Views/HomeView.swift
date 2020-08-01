//
//  HomeView.swift
//  EasyChat
//
//  Created by Shivam Rishi on 29/07/20.
//  Copyright © 2020 shivam. All rights reserved.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI

struct HomeView: View
{
    @State private var username = UserDefaults.standard.value(forKey: "userName") as! String
    @EnvironmentObject var data:MainObservable
    @State var show = false
    @State var chat = false
    @State var uid = ""
    @State var name = ""
    @State var profilePicUrl = ""
    
    var body: some View
    {
        
        ZStack
            {
                NavigationLink(destination: ChatView(uid: self.uid, name: self.name, profilePicUrl: self.profilePicUrl, chat: self.$chat), isActive: self.$chat) {
                    Text("")
                }
                
                VStack
                    {
                        
                        if self.data.recents.count == 0
                        {
                            
                            if self.data.noRecents
                            {
                                
                                Text("Start A Conversation With Someone")
                                    .foregroundColor(.black)
                                    .opacity(0.5)
                                
                            } else {
                                
                                Indicator()
                            }
                        } else {
                            ScrollView(.vertical, showsIndicators: false)
                            {
                                VStack
                                    {
                                        
                                        ForEach(data.recents.sorted(by: {$0.stamp > $1.stamp}))
                                        { i in
                                            
                                            Button(action: {
                                                
                                                self.uid = i.id
                                                self.name = i.name
                                                self.profilePicUrl = i.profilePicUrl
                                                
                                                self.chat.toggle()
                                            })
                                            {
                                                RecentCellView(name: i.name, url: i.profilePicUrl, date: i.date, time: i.time, lastMsg: i.lastMsg)
                                            }
                                            
                                            
                                            
                                        }
                                        
                                }.padding()
                                
                            }
                        }
                        
                }.navigationBarTitle("Home",displayMode: .inline)
                    .navigationBarItems(leading:
                        Button(action: {
                            
                            try! Auth.auth().signOut()
                            
                            UserDefaults.standard.set("", forKey: "userName")
                            UserDefaults.standard.set("", forKey: "profilePicUrl")
                            UserDefaults.standard.set("", forKey: "uid")
                            UserDefaults.standard.set(false, forKey: "status")
                            
                            NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
                            
                            
                        }) {
                            Text("SignOut")
                        }
                        
                        , trailing:
                        
                        Button(action: {
                            self.show.toggle()
                        }) {
                            Image(systemName: "square.and.pencil")
                                .resizable()
                                .frame(width: 25, height: 25)
                        }
                        
                        
                        
                )
                
        }
            
        .sheet(isPresented: self.$show) {
            SelectChatView(uid: self.$uid, name: self.$name, profilePicUrl: self.$profilePicUrl, show: self.$show, chat: self.$chat)
        }
        
    }
    
}


//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//
////        SelectChatView()
//    }
//}






