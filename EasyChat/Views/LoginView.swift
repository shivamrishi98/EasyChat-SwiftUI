//
//  LoginView.swift
//  EasyChat
//
//  Created by Shivam Rishi on 29/07/20.
//  Copyright © 2020 shivam. All rights reserved.
//

import SwiftUI
import Firebase
struct LoginView:View
{
    @State private var number:String = ""
    @State private var pinCode:String = ""
    
    @State private var show = false
    
    @State private var errMsg:String = ""
    
    @State private var alert = false
    
    @State var id = ""
    
    var body : some View {
        
        
        
        
        VStack(spacing: 0)
        {
            Image(systemName: "person.fill")
                .resizable()
                .frame(width: 200, height: 200)
            
            Spacer().frame(height:30)
            
            Text("Verify your Number")
                .font(.largeTitle)
                .fontWeight(.heavy)
            
            Text("Please enter your number to verify your account")
                .font(.body)
                .foregroundColor(.gray)
                .padding(.top,20)
            
            
            Spacer().frame(height:10)
            
            HStack{
                
                TextField("+91", text: $pinCode)
                    //                    .keyboardType(.numberPad)
                    .frame(width: 50)
                    .padding()
                    .background(Color("Color"))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                TextField("Enter Number", text: $number)
                    //                    .keyboardType(.numberPad)
                    .padding()
                    .background(Color("Color"))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                
                
            }
            Spacer().frame(height:20)
            
            
            NavigationLink(destination: OTPView(show: $show,id: $id), isActive: $show) {
                
                Button(action: {
                    
                    PhoneAuthProvider.provider().verifyPhoneNumber("+"+self.pinCode+self.number, uiDelegate: nil) { (id, error) in
                        
                        if error != nil
                        {
                            self.errMsg = error!.localizedDescription
                            self.alert.toggle()
                            return
                        }
                        
                        self.id  = id!
                        self.show.toggle()
                        
                    }
                    
                    
                    
                }) {
                    Text("Send OTP")
                        .frame(width: UIScreen.main.bounds.width - 30, height: 50)
                }
                    
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(10)
            }
                
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        }.padding()
            .alert(isPresented: $alert) {
                Alert(title: Text("Error"), message: Text(self.errMsg), dismissButton: .destructive(Text("OK")))
        }
        
        
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
