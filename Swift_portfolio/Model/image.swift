//
//  image.swift
//  Swift_portfolio
//
//  Created by Yu Watanabe on 2020/09/25.
//  Copyright © 2020 yu_w. All rights reserved.
//

import Foundation
import UIKit

class image{
    var delegate: UIImagePickerControllerDelegate & UINavigationControllerDelegate

    init(delegate_: UIImagePickerControllerDelegate & UINavigationControllerDelegate) {

        delegate = delegate_
    }
    
    func PresentPhotoLibrary(target: UIViewController, canEdit: Bool) {

        if !UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) && !UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.savedPhotosAlbum) {
            return
        }

        let type = kUTypeImage as String
        let imagePicker = UIImagePickerController()

        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {

            imagePicker.sourceType = .photoLibrary

            if let availableTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary) {

                if (availableTypes as NSArray).contains(type) {
                    imagePicker.mediaTypes = [type]
                    imagePicker.allowsEditing = canEdit
                }
            }
        } else if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            imagePicker.sourceType = .savedPhotosAlbum

            if let availableTypes = UIImagePickerController.availableMediaTypes(for: .savedPhotosAlbum) {

                if (availableTypes as NSArray).contains(type) {
                    imagePicker.mediaTypes = [type]
                }
            }
        } else {
            return
        }

        imagePicker.allowsEditing = canEdit
        imagePicker.delegate = delegate

        target.present(imagePicker, animated: true, completion: nil)

        return
    }
//    func imagePick(target: UIViewController) {
//        let sourceType:UIImagePickerController.SourceType = .photoLibrary
//        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
//            let cameraPicker = UIImagePickerController()
//            cameraPicker.allowsEditing = true
//            cameraPicker.sourceType = sourceType
//
//            cameraPicker.delegate = delegate
//            target.present(cameraPicker, animated: true, completion: nil)
//        }
//    }
//
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        picker.dismiss(animated: true, completion: nil)
//    }
    
    
}
