//
//  RegistrationView.swift
//  FootPrint
//
//  Created by 문다 on 2022/07/13.
//
//

import SwiftUI

struct RegistrationView: View {
    
    @State private var nickname = ""
    @State private var username = ""
    @State private var password = ""
    @Environment(\.presentationMode) var mode
    @EnvironmentObject var viewModel : AuthViewModel
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color("bgColor")], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                
                Text("Foot print")
                    .font(.system(size: 50, weight: .heavy, design: .serif))
                    .foregroundColor(Color("fontColor"))
                
                VStack {
                    
                    CustomTextField(text: $nickname, placeholder: Text("Nickname"), imageName: "face.smiling")
                        .padding()
                        .cornerRadius(15)
                        .border(.gray)
                        .padding(.horizontal, 32)
                    
                    CustomTextField(text: $username, placeholder: Text("Username"), imageName: "person")
                        .padding()
                        .cornerRadius(15)
                        .border(.gray)
                        .padding(.horizontal, 32)
                    
                    CustomSecureField(placeholder: Text("Password"), text: $password)
                        .padding()
                        .cornerRadius(15)
                        .border(.gray)
                        .padding(.horizontal, 32)
                    
                    // sign up
                    Button(action: {
                        viewModel.register(username: username, password: password, nickname: nickname)
                    }, label: {
                        Text("Sign Up")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 360, height: 50)
                            .background(Color("blue"))
                        // frame 크기를 설정한 후에 배경 색을 지정해야 사이즈맞게 적용된다.
                            .clipShape(Capsule())
                        // 마찬가지로 클립쉐이프도 배경색이 지정된 후에 짤라주어야 한다.
                            .padding()
                    })
                    
                    Spacer()
                    
                    Button(action: {mode.wrappedValue.dismiss()}, label: {
                        // go to sign in
                            HStack {
                                Text("Already have an account?")
                                    .font(.system(size: 13))
                                    .foregroundColor(.black)
                                
                                Text("Sign In")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(.black)
                            }
                            .padding(.bottom, 16)
                    })
                }
                .padding(.top, 100)
            }
            .padding(.top, 110)
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
