//
//  PrivateSettingView.swift
//  FootPrint
//
//  Created by 문다 on 2022/05/09.
//

import SwiftUI

struct PrivateSettingView: View {
    
    @State private var email: String = ""
    @State private var phone: String = ""
    @State private var gender: String = ""
    @State private var birth: String = "" 
    
    var body: some View {
        VStack {
            CustomTextField(text: $email, placeholder: Text("Email"), imageName: "envelope")
                .padding()
                .cornerRadius(15)
                .border(.gray)
                .padding(.horizontal, 20)
            CustomTextField(text: $phone, placeholder: Text("Phone number"), imageName: "phone")
                .padding()
                .cornerRadius(15)
                .border(.gray)
                .padding(.horizontal, 20)
            CustomTextField(text: $gender, placeholder: Text("Gender"), imageName: "person.text.rectangle")
                .padding()
                .cornerRadius(15)
                .border(.gray)
                .padding(.horizontal, 20)
            CustomTextField(text: $birth, placeholder: Text("Birthday"), imageName: "gift")
                .padding()
                .cornerRadius(15)
                .border(.gray)
                .padding(.horizontal, 20)
            
            HStack {
                Spacer()
                
                NavigationLink(destination: SecuritySettingView(), label: {
                    Text("비밀번호 변경")
                        .padding()
                })
            }
            Spacer()
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            if email.isEmpty || phone.isEmpty || gender.isEmpty || birth.isEmpty {
                                // 빈칸있도록?
                                // 기존에 저장된 정보를 불러와서 입력되어 있도록 
                            }
                        }, label: {
                            Image(systemName: "checkmark")
                    })
                }
            }
        }
    }
}
