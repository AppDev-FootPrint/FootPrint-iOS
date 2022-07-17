//
//  CreateDetailInfo.swift
//  FootPrint
//
//  Created by 문다 on 2022/05/02.
//

import SwiftUI

struct CreateDetailTravelView: View {
    
    @State private var searchKeyword: String = ""
    @State private var comment: String = ""
    
    @State private var selectedImage: UIImage?
    @State private var image: Image?
    @State var imagePickerPresented = false
    
    @State var numberOfPriceInfo : Int
    @State var numberOfTipInfo : Int
    
    var body: some View {
        VStack {
            
            HStack {
                Spacer()
                
                Button(action: {}, label: {
                    Text("임시저장")
                        .font(.system(size: 13))
                        .foregroundColor(.white)
                        .frame(width: 80, height: 25)
                        .background(.gray)
                        .cornerRadius(20)
                })
                Button(action: {}, label: {
                    Text("등록하기")
                        .font(.system(size: 13))
                        .foregroundColor(.white)
                        .frame(width: 80, height: 25)
                        .background(Color("blue"))
                        .cornerRadius(20)
                })
            }
            .padding(.trailing, 20)
            
            ScrollView {
                
                HStack {
                    Image(systemName: "magnifyingglass")
                        .padding(.leading)
                    TextField("Search locations...", text: $searchKeyword)
                        .disableAutocorrection(true)
                        .padding([.bottom, .top, .trailing])
                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        // poop code !!
                        ForEach (0..<2) { _ in
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.white)
                                .frame(width: 80, height: 80)
                                .padding(10)
                                .background(Color.gray)
                                .cornerRadius(10)
                                .padding(7)
                        }
                        
                        // 생성 후 아이템 추가 코드 구현
                        
                        ZStack {
                            if let image = image {
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .foregroundColor(.white)
                                    .frame(width: 80, height: 80)
                                    .padding(10)
                                    .background(Color.gray)
                                    .cornerRadius(10)
                                    .padding(7)
                                
                            } else {
                                Button(action: {imagePickerPresented.toggle()}, label: {
                                    Image(systemName: "plus")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundColor(.gray)
                                        .frame(width:40, height: 40)
                                        .padding(30)
                                        .overlay(Rectangle()
                                                    .stroke(style: StrokeStyle(lineWidth: 2, dash: [15]))
                                                    .foregroundColor(.gray)
                                        )
                                        .padding(7)
                                })
                                    .sheet(isPresented: $imagePickerPresented, onDismiss: loadImage, content: {
                                    ImagePicker(image: $selectedImage)
                                })
                                .padding()
                            }
                        }
                    }
                }
                
                // Comment
                HStack {
                    Image(systemName: "bubble.left")
                    Text("Comment")
                    Spacer()
                }
                .padding()
                
                TextField(" type texts...", text: $comment)
                    .padding()
                    .frame(height: 200)
                    .background(Color("lightgray"))
                    .padding([.leading, .trailing])
                
                // Price info
                HStack {
                    Image(systemName: "tag")
                    Text("Price")
                    Spacer()
                }
                .padding()
                
                ForEach (0..<numberOfPriceInfo, id:\.self) { _ in
                    PriceCell()
                }
                
                // !! duplicated - dotted box
                Button(action: {
                    self.numberOfPriceInfo += 1
                }, label: {
                    Image(systemName: "plus")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.gray)
                        .frame(width: 320, height: 20)
                        .padding(10)
                        .overlay(Rectangle()
                                    .stroke(style: StrokeStyle(lineWidth: 2, dash: [10]))
                                    .foregroundColor(.gray)
                        )
                })
                
                // 생성 후 아이템 추가 코드 구현
                
                // Tips
                HStack {
                    Image(systemName: "questionmark")
                    Text("Tip")
                    Spacer()
                }
                .padding()
                
                // !! duplicated - dotted box
                Button(action: {}, label: {
                    Image(systemName: "plus")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.gray)
                        .frame(width: 320, height: 20)
                        .padding(10)
                        .overlay(Rectangle()
                                    .stroke(style: StrokeStyle(lineWidth: 2, dash: [10]))
                                    .foregroundColor(.gray)
                        )
                })
                
                // 생성 후 아이템 추가 코드 구현 
            }
        }
    }
}


extension CreateDetailTravelView {
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        image = Image(uiImage: selectedImage)
    }
}


struct CreateDetailTravelView_Previews: PreviewProvider {
    static var previews: some View {
        CreateDetailTravelView(numberOfPriceInfo: 0, numberOfTipInfo: 1)
    }
}
