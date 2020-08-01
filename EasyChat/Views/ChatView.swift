//
//  ChatView.swift
//  EasyChat
//
//  Created by Shivam Rishi on 30/07/20.
//  Copyright © 2020 shivam. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct ChatView: View
{
    var uid:String
    var name:String
    var profilePicUrl:String
    @Binding var chat:Bool
    
    @State var msgs: [Msg] = [Msg]()
    @State var txt = ""
    @State var noMsg = false
    var body:some View
    {
        VStack
            {
                
                if msgs.count == 0
                {
                    
                    if self.noMsg
                    {
                        Text("Start a New Conversation!!!")
                            .foregroundColor(.black).opacity(0.5).padding()
                        Spacer()
                    } else {
                        
                        
                        Spacer()
                        Indicator()
                        Spacer()
                    }
                } else {
                    ScrollView(.vertical, showsIndicators: false)
                    {
                        VStack
                            {
                                ForEach(self.msgs)
                                { i in
                                    
                                    
                                    HStack
                                        {
                                            
                                            if i.user == UserDefaults.standard.value(forKey: "uid") as! String
                                            {
                                              
                                                Spacer()
                                                Text(i.msg)
                                                    .padding()
                                                    .background(Color.blue)
                                                    .clipShape(ChatBubble(msg: true))
                                                    .foregroundColor(.white)
                                                
                                                
                                            } else {
                                                Text(i.msg)
                                                    .padding()
                                                    .background(Color.green)
                                                    .clipShape(ChatBubble(msg: false))
                                                    .foregroundColor(.white)
                                                
                                                
                                                Spacer()
                                            }
                                            
                                            
                                    }.padding(.top,5)
                                    
                                    
                                    
                                }
                        }
                    }
                }
                
                HStack
                    {
                        TextField("Enter message", text: self.$txt)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        Button(action: {
                            
                            sendMsg(uid: self.uid, pic: self.profilePicUrl, name: self.name, msg: self.txt, date: Date())
                            
                            self.txt = ""
                            
                        })
                        {
                            Text("Send")
                        }
                        
                }
                    
                .navigationBarTitle("\(name)",displayMode: .inline)
                .navigationBarItems(leading:
                    Button(action: {
                        self.chat.toggle()
                    })
                    {
                        Image(systemName: "arrow.left")
                            .resizable()
                            .frame(width: 20, height: 15)
                    }
                )
        }.padding()
            .onAppear {
                self.getMsgs()
                print(UserDefaults.standard.value(forKey: "uid") as! String)
                
        }
    }
    
func getMsgs()
{
    
    let db = Firestore.firestore()
    
    let uid = Auth.auth().currentUser?.uid
    
    db.collection("msgs").document(uid!).collection(self.uid).order(by: "date", descending: false).addSnapshotListener { (snap, error) in
        if error != nil
        {
            print(error!.localizedDescription)
            self.noMsg = true
            return
        }
        
        if snap!.isEmpty
        {
            self.noMsg = true
            
        }
        
        for i in snap!.documentChanges
        {
            
            if i.type == .added
            {
                let id = i.document.documentID
                let msg = i.document.get("msg") as! String
                let user = i.document.get("userUID") as! String
                
                self.msgs.append(Msg(id: id, msg: msg, user: user))
            }
            
            
            
        }
    }
    
    
}
}
