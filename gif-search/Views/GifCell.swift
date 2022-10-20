//
//  GifCell.swift
//  gif-search
//
//  Created by Rhee on 10/17/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct GifCell: View {
    @ObservedObject var gifCellVM: GifCellViewModel
    
    @State var openModal: Bool
    
    let singleGif: dataStructure
    
    var body: some View {
        ZStack {
            VStack{
                Button(action: {
                    openModal.toggle()
                }) {
                    AnimatedImage(url: URL(string: singleGif.gifSources.original.url)!)
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width - 220, height: 100)
                        .cornerRadius(15)

                }.fullScreenCover(isPresented: $openModal) {
                    SaveModal(openModal: $openModal, gifURL: singleGif.gifSources.original.url, gifMP4: singleGif.gifSources.original.mp4, success: false)
                }

            }
        }
    }
}

//struct GifCell_Previews: PreviewProvider {
//    static var previews: some View {
//        GifCell(gifCellVM: <#GifCellViewModel#>, singleGif: <#dataStructure#>)
//    }
//}
