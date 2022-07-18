//
//  SecuritySetting.swift
//  FootPrint
//
//  Created by 문다 on 2022/05/09.
//

import SwiftUI

struct SecuritySettingView: View {
    
    @State var currentPW: String = ""
    @State var newPW : String = ""
    @State var confirmPW: String = ""
    
    var body: some View {
        VStack {
            CustomSecureField(placeholder: Text("Current Password"), text: $currentPW)
                .padding(.top)
            CustomSecureField(placeholder: Text("New Password"), text: $newPW)
            
            HStack {
                Text("Confirm Password")
                    .font(.system(size: 18, weight: .semibold))
                    .padding([.leading, .trailing])
                Spacer()
            }
            SecureField("Confirm password...", text: $confirmPW)
                .padding()
                .border(.black, width:2)
                .padding([.leading, .trailing])
            
            if !newPW.isEmpty || !confirmPW.isEmpty {
                if newPW == confirmPW {
                    HStack {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                        
                        Text("Confirm!")
                            .foregroundColor(.green)
                        
                        Spacer()
                    }
                    .padding(.leading)
                } else {
                    HStack {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.red)
                        
                        Text("Incorrect!")
                            .foregroundColor(.red)
                        
                        Spacer()
                    }
                    .padding(.leading)
                }
            }
            
            HStack {
                Spacer()
                
                Button(action: {
                    if currentPW.isEmpty {
                        // 현재 비밀번호를 입력하지않으면 변경 불가
                        // 기존 비밀번호 확인 및 새 비밀번호로 변경
                    }
                }, label: {
                    Text("Change")
                        .foregroundColor(.white)
                        .frame(width: 100, height: 40)
                        .background(Color("blue"))
                        .cornerRadius(20)
                        .padding(.trailing)
                })
            }
            Spacer()
        }
    }
}

struct SecuritySettingView_Previews: PreviewProvider {
    static var previews: some View {
        SecuritySettingView()
    }
}
