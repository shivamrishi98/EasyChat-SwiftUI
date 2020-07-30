//
//  ImagePicker.swift
//  EasyChat
//
//  Created by Shivam Rishi on 29/07/20.
//  Copyright © 2020 shivam. All rights reserved.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable
{
    
    @Binding var picker:Bool
    @Binding var imageData:Data
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController{
        
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        
    }
    
    func makeCoordinator() -> ImagePicker.Coordinator {
        
        return ImagePicker.Coordinator(parent:self)
    }
    
    class Coordinator:NSObject, UIImagePickerControllerDelegate,UINavigationControllerDelegate
    {
        var parent:ImagePicker
        
        init(parent:ImagePicker)
        {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            let image = info[.originalImage] as! UIImage
            
            let data = image.jpegData(compressionQuality: 0.45)
            
            self.parent.imageData = data!
            
            self.parent.picker.toggle()
            
        }
        
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            self.parent.picker.toggle()
        }
        
    }
    
    
}


