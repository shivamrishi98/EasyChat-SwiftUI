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
    var body: some View
    {
        VStack
            {
                
                if self.data.recents.count == 0
                {
                    Indicator()
                } else {
                    ScrollView(.vertical, showsIndicators: false)
                    {
                        VStack
                            {
                                
                                ForEach(data.recents)
                                { i in
                                    RecentCellView(name: i.name, url: i.profilePicUrl, date: i.date, time: i.time, lastMsg: i.lastMsg)
                                }
                                
                        }.padding()
                        
                    }
                }
                
        }.navigationBarTitle("Home",displayMode: .inline)
            .navigationBarItems(leading:
                Button(action: {
                    
                }) {
                    Text("SignOut")
                }
                
                , trailing:
                
                Button(action: {
                    
                }) {
                    Image(systemName: "square.and.pencil")
                        .resizable()
                        .frame(width: 25, height: 25)
                }
                
                
                
        )
        
    }
    
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        
      HomeView()
    }
}

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
                                    Text(name)
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

