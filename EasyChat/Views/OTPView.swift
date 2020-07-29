//
//  OTPView.swift
//  EasyChat
//
//  Created by Shivam Rishi on 29/07/20.
//  Copyright © 2020 shivam. All rights reserved.
//

import SwiftUI
import Firebase

struct OTPView:View
{
    @State private var otpCode:String = ""
    @Binding var show:Bool
    @Binding var id:String
    
    @State private var errMsg:String = ""
    
    @State private var alert = false
    
    var body : some View {
        
        
        ZStack(alignment: .topLeading)
        {
            GeometryReader { _ in
                
                VStack(spacing: 0)
                {
                    Image(systemName: "person.fill")
                        .resizable()
                        .frame(width: 200, height: 200)
                    
                    Spacer().frame(height:30)
                    
                    Text("Verification Code")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                    
                    Text("Please enter verification code")
                        .font(.body)
                        .foregroundColor(.gray)
                        .padding(.top,20)
                    
                    
                    Spacer().frame(height:10)
                    
                    
                    
                    TextField("Enter OTP", text: self.$otpCode)
                        //                        .keyboardType(.numberPad)
                        .padding()
                        .background(Color("Color"))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    
                    
                    
                    Spacer().frame(height:20)
                    
                    
                    
                    
                    
                    Button(action: {
                        
                        let credentials = PhoneAuthProvider.provider().credential(withVerificationID: self.id, verificationCode: self.otpCode)
                        
                        Auth.auth().signIn(with: credentials) { (data, error) in
                            if error != nil
                            {
                                
                                self.errMsg = error!.localizedDescription
                                self.alert.toggle()
                                return
                            }
                            
                            UserDefaults.standard.set(true, forKey: "status")
                            
                            NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
                            
                            
                        }
                        
                    }) {
                        Text("Verify OTP")
                            .frame(width: UIScreen.main.bounds.width - 30, height: 50)
                    }
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                    .navigationBarBackButtonHidden(true)
                }
                
                
            }
            
            
            Button(action: {
                self.show.toggle()
            })
            {
                Image(systemName: "chevron.left")
            }.foregroundColor(.blue)
            
            
        }
        .padding()
        .alert(isPresented: $alert) {
            Alert(title: Text("Error"), message: Text(self.errMsg), dismissButton: .destructive(Text("OK")))
        }
        
        
    }
}



