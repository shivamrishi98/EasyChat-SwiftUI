//
//  ChatView.swift
//  EasyChat
//
//  Created by Shivam Rishi on 30/07/20.
//  Copyright © 2020 shivam. All rights reserved.
//

import SwiftUI

struct ChatView: View
{
    var uid:String
    var name:String
    var profilePicUrl:String
    @Binding var chat:Bool
    
    var body:some View
    {
        Text("hi")
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
    }
    
}


//struct ChatView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChatView()
//    }
//}
