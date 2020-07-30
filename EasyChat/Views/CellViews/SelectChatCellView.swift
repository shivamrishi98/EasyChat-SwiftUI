//
//  SelectChatCellView.swift
//  EasyChat
//
//  Created by Shivam Rishi on 30/07/20.
//  Copyright © 2020 shivam. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI
struct SelectChatCellView: View
{
    
    var name:String
    var about:String
    var profilePicUrl:String
    
    var body:some View
    {
        HStack
            {
                AnimatedImage(url: URL(string: profilePicUrl)!)
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 55, height: 55)
                    .clipShape(Circle())
                
                VStack
                    {
                        
                        HStack
                            {
                                VStack(alignment: .leading, spacing: 6)
                                {
                                    Text(name).foregroundColor(.black)
                                    Text(about).foregroundColor(.gray)
                                }
                                
                                Spacer()
                                
                                
                        }
                        Divider()
                        
                }
                
                
        }
    }
    
}

//struct SelectChatCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        SelectChatCellView()
//    }
//}
