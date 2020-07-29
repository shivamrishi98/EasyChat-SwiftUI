//
//  SignUpView.swift
//  EasyChat
//
//  Created by Shivam Rishi on 29/07/20.
//  Copyright © 2020 shivam. All rights reserved.
//

import SwiftUI


struct SignUpView: View
{
    @Binding var show:Bool
    
    @State  var name:String = ""
    @State  var about:String = ""
    @State  var imageData:Data = .init(count: 0)
    @State  var picker:Bool = false
    @State  var loading:Bool = false
    
    @State private var alert = false
    
    var body: some View
    {
        VStack(alignment: .leading, spacing: 0)
        {
            Text("Create an Account")
                .font(.title)
            
            HStack
                {
                    Spacer()
                    
                    Button(action: {
                        self.picker.toggle()
                    }) {
                        
                        if self.imageData.count == 0 {
                            Image(systemName: "person.crop.circle.badge.plus")
                                .resizable()
                                .renderingMode(.original)
                                .frame(width: 90,height: 70)
                                .foregroundColor(.gray)
                        } else {
                            
                            Image(uiImage: UIImage(data: self.imageData)!)
                                .renderingMode(.original)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                
                                .frame(width: 90,height: 90)
                                .clipShape(Circle())
                            
                        }
                        
                        
                        
                        
                    }
                    
                    Spacer()
            }
            .padding(.vertical,15)
            
            Text("Please enter username")
                .font(.body)
                .foregroundColor(.gray)
                .padding(.top,20)
            
            
            Spacer().frame(height:10)
            
            
            
            TextField("Enter username", text: self.$name)
                .padding()
                .background(Color("Color"))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            Text("About you")
                .font(.body)
                .foregroundColor(.gray)
                .padding(.top,20)
            
            
            Spacer().frame(height:10)
            
            
            
            TextField("Tell us something About you", text: self.$about)
                .padding()
                .background(Color("Color"))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            
            Spacer().frame(height:10)
            
            if self.loading
            {
                
                HStack
                    {
                        Spacer()
                        
                        Indicator()
                        
                        Spacer()
                        
                }
                
                
            } else {
                
                Button(action: {
                    
                    
                    
                    if self.name != "" && self.about != "" && self.imageData.count != 0
                    {
                        self.loading.toggle()
                        
                        createUser(name: self.name, about: self.about, imageData: self.imageData)
                        { (status) in
                            
                            if status
                            {
                                self.show.toggle()
                            }
                            
                        }
                    } else {
                        self.alert.toggle()
                    }
                }) {
                    
                    Text("SignUp")
                        .frame(width: UIScreen.main.bounds.width - 30, height: 50)
                }
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(10)
            }
            
        }
        .padding()
        .sheet(isPresented: self.$picker, content: {
            ImagePicker(picker: self.$picker, imageData: self.$imageData)
        })
            .alert(isPresented: self.$alert) {
                Alert(title: Text("Fill"), message: Text("Please fill all the details"), dismissButton: .destructive(Text("OK")))
        }
    }
}









//struct SignUpView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignUpView()
//    }
//}
