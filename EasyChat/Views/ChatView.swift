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
                                            
                                            if i.id == UserDefaults.standard.value(forKey: "uid") as! String
                                            {
                                                Spacer()
                                                Text(i.msg)
                                                    .padding()
                                                    .clipShape(ChatBubble(msg: true))
                                                    .foregroundColor(.white)
                                                    .background(Color.blue)
                                                
                                            } else {
                                                Text(i.msg)
                                                    .padding()
                                                    .clipShape(ChatBubble(msg: false))
                                                    .foregroundColor(.white)
                                                    .background(Color.green)
                                                Spacer()
                                            }
                                            
                                            
                                    }
                                    
                                    
                                    
                                }
                        }
                    }
                }
                
                HStack
                    {
                        TextField("Enter message", text: self.$txt)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        Button(action: {
                            
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
    }
    
    func getMsgs()
    {
        
        let db = Firestore.firestore()
        
        let uid = Auth.auth().currentUser?.uid
        
        db.collection("msgs").document(uid!).collection(uid!).order(by: "date", descending: false).getDocuments { (snap, error) in
            
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
            
            for i in snap!.documents
            {
                let id = i.documentID
                let msg = i.get("msg") as! String
                let user = i.get("user") as! String
                
                self.msgs.append(Msg(id: id, msg: msg, user: user))
                
            }
            
            
        }
        
        
    }
    
    
}



struct Msg:Identifiable
{
    var id:String
    var msg:String
    var user:String
}

//struct ChatView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChatView()
//    }
//}

struct ChatBubble: Shape
{
    var msg:Bool
    
    func path(in rect: CGRect) -> Path {
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft,.topRight, msg ? .bottomLeft: .bottomRight], cornerRadii: CGSize(width: 16, height: 16))
        
        return Path(path.cgPath)
    }
    
}
