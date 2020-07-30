//
//  RecentCellView.swift
//  EasyChat
//
//  Created by Shivam Rishi on 30/07/20.
//  Copyright © 2020 shivam. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI
struct RecentCellView: View
{
    
    var name:String
    var url:String
    var date:String
    var time:String
    var lastMsg:String
    
    
    
    var body:some View
    {
        HStack
            {
                AnimatedImage(url: URL(string: url)!)
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
                                    Text(lastMsg).foregroundColor(.gray)
                                }
                                
                                Spacer()
                                
                                VStack(alignment: .leading, spacing: 6)
                                {
                                    Text(date).foregroundColor(.gray)
                                    Text(time).foregroundColor(.gray)
                                }
                        }
                        Divider()
                        
                }
                
                
        }
    }
    
}
//
//struct RecentCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecentCellView()
//    }
//}
