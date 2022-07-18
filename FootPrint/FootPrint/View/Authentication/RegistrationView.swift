//
//  RegistrationView.swift
//  FootPrint
//
//  Created by 문다 on 2022/07/13.
//
//

import SwiftUI
import PopupView

struct RegistrationView: View {
    
    @State private var nickname = ""
    @State private var username = ""
    @State private var password = ""
    @State var showWarning = false // 빈칸있으면 가입불가
    
    @Environment(\.presentationMode) var mode
    @EnvironmentObject var viewModel : AuthViewModel
    
    var body: some View {
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
                    Text("* FILL IN ALL THE BLANKS")
                        .font(.system(size: 20, weight: .heavy, design: .serif))
                        .foregroundColor(Color("gray"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 30)
                    
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
                        if nickname.count == 0 || username.count == 0 || password.count == 0 {
                            self.showWarning = true
                        } else {
                            viewModel.register(username: username, password: password, nickname: nickname)
                        }
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
        .onReceive(viewModel.$created, perform: { completed in
            if completed {
                self.mode.wrappedValue.dismiss()
            }
        })
        .popup(isPresented: $showWarning, type: .floater(), position: .bottom, autohideIn: 2) {
            Text("회원가입 실패!\n 빈칸을 모두 채워주세요 :(")
                .frame(width: 230, height: 60)
                .foregroundColor(.white)
                .background(Color("red"))
                .cornerRadius(30.0)
                .multilineTextAlignment(.center)
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
