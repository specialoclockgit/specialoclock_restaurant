//
//  ImagePicker.swift
//  Nexever
//
//  Created by apple on 29/05/21.
//

import Foundation
import UIKit
import QCropper


class ImagePicker: NSObject, UIImagePickerControllerDelegate,UINavigationControllerDelegate, CropperViewControllerDelegate {
    func cropperDidConfirm(_ cropper: CropperViewController, state: CropperState?) {
        cropper.dismiss(animated: true, completion: nil)
        
        if let state = state,
           let image = cropper.originalImage.cropped(withCropperState: state) {
            cropperState = state
            self.pickImageCallback?(image)
            print(cropper.isCurrentlyInInitialState)
            print(image)
        }
        rootVC?.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    var picker = UIImagePickerController()
    var alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
    var viewController: UIViewController?
    var pickImageCallback : ((UIImage) -> ())?
    var pathUrl : ((URL?)->())?
    var image = UIImage()
    var videoURL: URL?
    
    var cropperState: CropperState?
    override init(){
        super.init()
    }
    func pickImage(_ viewController: UIViewController, _ callback: @escaping ((UIImage) -> ()))
    {
        pickImageCallback = callback;
        self.viewController = viewController;
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default){
            UIAlertAction in
            self.openCamera()
        }
        let galleryAction = UIAlertAction(title: "Gallery", style: .default){
            UIAlertAction in
            self.openGallery()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel){
            UIAlertAction in
        }
        
        // Add the actions
        picker.delegate = self
        alert.addAction(cameraAction)
        alert.addAction(galleryAction)
        alert.addAction(cancelAction)
        alert.popoverPresentationController?.sourceView = self.viewController!.view
        viewController.present(alert, animated: true, completion: nil)
    }
    
    func openCamera() {
        alert.dismiss(animated: true, completion: nil)
        if(UIImagePickerController .isSourceTypeAvailable(.camera)){
            picker.sourceType = .camera
            picker.mediaTypes = ["public.image"]
            self.viewController!.present(picker, animated: true, completion: nil)
        } else {
            CommonUtilities.shared.showAlert(message: "You don't have camera")
        }
    }
    func openGallery() {
        alert.dismiss(animated: true, completion: nil)
        picker.sourceType = .photoLibrary
        picker.mediaTypes = ["public.image"]
        self.viewController!.present(picker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: false, completion: nil)
        var image = UIImage()
        
        if let imageOriginal = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        {
            image = imageOriginal
            
            let cropper = CropperViewController(originalImage: imageOriginal)
            cropper.delegate = self
            picker.dismiss(animated: false) {
                rootVC?.present(cropper, animated: false, completion: nil)
            }
        }
        else
        {
            if let media =  info[UIImagePickerController.InfoKey.mediaURL] as? URL {
                do
                {
                    guard let image = info[.originalImage] as? UIImage else{ return}
                    self.pickImageCallback?(image)
                    self.pathUrl?(media)
                    picker.delegate = nil
                }
                catch
                {
                    print("Unable to load data: \(error)")
                }
            }
            else
            {
                image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
                
                let cropper = CropperViewController(originalImage: image)
                cropper.delegate = self
                picker.dismiss(animated: true) {
                    rootVC?.present(cropper, animated: false, completion: nil)
                }
            }
        }
    }
    
    
    @objc func imagePickerController(_ picker: UIImagePickerController, pickedImage: UIImage?) {
    }
    
}
