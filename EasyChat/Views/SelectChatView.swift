//
//  SelectChatView.swift
//  EasyChat
//
//  Created by Shivam Rishi on 30/07/20.
//  Copyright © 2020 shivam. All rights reserved.
//

import SwiftUI


struct SelectChatView:View
{
    @ObservedObject var data = getUsers()
    @Binding var uid:String
     @Binding var name:String
     @Binding var profilePicUrl:String
     @Binding var show:Bool
     @Binding var chat:Bool
    
    var body: some View
    {
        VStack(alignment: .leading)
        {
            
            
            if self.data.users.count == 0
            {
                Indicator()
            } else {
                
                Text("Select user to chat").font(.largeTitle).foregroundColor(.black).opacity(0.5)
                
                ScrollView(.vertical, showsIndicators: false)
                {
                    VStack
                        {
                            
                            ForEach(data.users)
                            { i in
                                
                                Button(action: {
                                    self.uid = i.id
                                    self.name = i.name
                                    self.profilePicUrl = i.profilePicUrl
                                    self.show.toggle()
                                    self.chat.toggle()
                                })
                                {
                                    SelectChatCellView(name: i.name, about: i.about, profilePicUrl: i.profilePicUrl)
                                }
                                
                                
                            }
                            
                    }
                    
                }
                
                
            }
        }.padding()
    }
    
}

//struct SelectChatView_Previews: PreviewProvider {
//    static var previews: some View {
//        SelectChatView()
//    }
//}
