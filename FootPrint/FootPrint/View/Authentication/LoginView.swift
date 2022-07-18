//
//  LoginView.swift
//  FootPrint
//
//  Created by 문다 on 2022/07/13.
//
//

import SwiftUI
import PopupView

struct LoginView: View {
    
    @State private var username = ""
    @State private var password = ""
    @State private var showWarning: Bool = false
    @EnvironmentObject var viewModel : AuthViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(colors: [Color("lightgray")], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                VStack {
                    HStack {
                        Text("Foot Print")
                            .font(.system(size: 50, weight: .heavy, design: .serif))
                            .foregroundColor(Color("darkgray"))
                            .frame(alignment: .center)
                        
                        Image("footprint")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(Color("darkgray"))
                            .rotationEffect(.degrees(40))
                            .scaledToFit()
                            .frame(width: 60)
                            .padding(.bottom, 40)
                    }
                    
                    VStack {
                        Text("* LOGIN IS REQUIRED")
                            .font(.system(size: 20, weight: .heavy, design: .serif))
                            .foregroundColor(Color("gray"))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 30)
                        
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
                        
                        // sign in
                        Button(action: {
                            if username.count == 0 || password.count == 0 {
                                self.showWarning = true
                            } else {
                                viewModel.login(username: username, password: password)
                            }
                        }, label: {
                            Text("Sign in")
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
                        
                        NavigationLink(destination: RegistrationView().navigationBarHidden(true), label: {
                            // go to sign in
                                HStack {
                                    Text("Don't have an account?")
                                        .font(.system(size: 13))
                                        .foregroundColor(.black)
                                    
                                    Text("Sign up")
                                        .font(.system(size: 14, weight: .semibold))
                                        .foregroundColor(.black)
                                }
                                .padding(.bottom, 16)
                        })
                    }
                    .padding(.top, 70)
                }
                .padding(.top)
            }
        }
        .popup(isPresented: $showWarning, type: .floater(), position: .bottom, autohideIn: 2) {
            Text("로그인 실패!\n 입력하지않은 정보가 있습니다 :(")
                .frame(width: 270, height: 60)
                .foregroundColor(.white)
                .background(Color("red"))
                .cornerRadius(30.0)
                .multilineTextAlignment(.center)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
