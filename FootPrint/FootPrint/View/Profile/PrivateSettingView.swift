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
            
            // placeholder 변수가 private이면 매개인자로 사용불가하니까 없애도록! 
            CustomTextField(placeholder: "Email", text: $email)
            CustomTextField(placeholder: "Phone number", text: $phone)
            CustomTextField(placeholder: "Gender", text: $gender)
            CustomTextField(placeholder: "Birthday", text: $birth)
            
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
