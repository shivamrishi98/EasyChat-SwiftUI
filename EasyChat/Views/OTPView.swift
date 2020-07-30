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
    
    @State private var creation = false
    @State private var loading = false
    
    
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
                            
                            self.loading.toggle()
                            
                            let credentials = PhoneAuthProvider.provider().credential(withVerificationID: self.id, verificationCode: self.otpCode)
                            
                            Auth.auth().signIn(with: credentials) { (data, error) in
                                if error != nil
                                {
                                    
                                    self.errMsg = error!.localizedDescription
                                    self.alert.toggle()
                                    self.loading.toggle()
                                    return
                                }
                                
                                
                                
                                checkUser { (exists,user,uid,profilePicUrl) in
                                    if exists
                                    {
                                        
                                        UserDefaults.standard.set(true, forKey: "status")
                                        UserDefaults.standard.set(user, forKey: "userName")
                                        
                                         UserDefaults.standard.set(uid, forKey: "uid")
                                         UserDefaults.standard.set(profilePicUrl, forKey: "profilePicUrl")
                                        
                                        NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
                                        
                                        
                                    } else {
                                        self.creation.toggle()
                                        self.loading.toggle()
                                        
                                    }
                                }
                                
                                
                                
                            }
                            
                        }) {
                            Text("Verify OTP")
                                .frame(width: UIScreen.main.bounds.width - 30, height: 50)
                        }
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                        
                        
                        
                    }
                    
                    
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
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .alert(isPresented: $alert) {
            Alert(title: Text("Error"), message: Text(self.errMsg), dismissButton: .destructive(Text("OK")))
        }
        .sheet(isPresented: $creation) {
            SignUpView(show: self.$creation)
        }
        
        
    }
}


struct OTPView_Previews: PreviewProvider {


    static var previews: some View {
       PreviewWrapper()
    }
}

struct PreviewWrapper: View {
    @State(initialValue: false) var show:Bool
    @State(initialValue: "") var id: String

    var body: some View {
         OTPView(show: $show, id: $id)
    }
  }





