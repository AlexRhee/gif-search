//
//  ImageSaver.swift
//  gif-search
//
//  Created by Rhee on 10/17/22.
//

import Foundation
import SwiftUI
import Combine
import SDWebImageSwiftUI
import PhotosUI

class ImageSaver: NSObject {
    func writeToPhotoAlbum(image: String, completion: @escaping (Bool) -> Void) {
        
        //Save the gif as a video to the device's photo library
        DispatchQueue.global(qos: .background).async {
            if let url = URL(string: image),
                let urlData = NSData(contentsOf: url) {
                let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0];
                let filePath="\(documentsPath)/tempFile.mp4"
                DispatchQueue.main.async {
                    urlData.write(toFile: filePath, atomically: true)
                    PHPhotoLibrary.shared().performChanges({
                        PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: URL(fileURLWithPath: filePath))
                    }) { completed, error in
                        if completed {
                            print("GIF saved!")
                            completion(true)
                        } else {
                            print(error as Any)
                            completion(false)
                        }
                    }
                }
            }
        }
    }
//
//    @objc func saveCompleted(_ image: String, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
//        print("Save finished!")
//    }
}
