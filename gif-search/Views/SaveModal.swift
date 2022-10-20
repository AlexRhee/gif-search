//
//  SaveModal.swift
//  gif-search
//
//  Created by Rhee on 10/18/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct SaveModal: View {
    //Binding var to open/close the modal
    @Binding var openModal: Bool
    
    @State var gifURL: String
    @State var gifMP4: String
    @State var success = false
    
    var body: some View {
        VStack {
            HStack{
                Button(action: {
                    self.openModal.toggle()
                }) {
                    Image(systemName: "chevron.backward")
                        .font(.system(size: 18, weight: .medium, design: .rounded))
                        .padding([.top,.leading,.trailing], 25)
                    Text("Back")
                        .padding(.top, 25)
                        .padding(.leading,-20)
                }
                Spacer()
            }
            Spacer()
                .frame(height: 100)

            if (success) {
                Text("GIF Saved!")
            } else {
                Text("Click GIF to Save")
            }

            Button(action: {
                    let imageSaver = ImageSaver()
                imageSaver.writeToPhotoAlbum(image: gifMP4) { result in
                    if result {
                        self.success = true
                    } else {
                        self.success = false
                    }
                }
            }) {
                AnimatedImage(url: URL(string: self.gifURL)!)
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width - 100, height: 200)
                    .cornerRadius(15)
            }
            Spacer()
        }
        .padding(10)
    }
}

struct SaveModal_Previews: PreviewProvider {
    static var previews: some View {
        SaveModal(openModal: .constant(true), gifURL: "", gifMP4: "")
    }
}
