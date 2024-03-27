////
////  ImagePicker.swift
////  dovecutprovider
////
////  Created by cqlapple on 01/09/22.
////
//
//import Foundation
//import UIKit
//import MediaPlayer
//import Photos
//import MobileCoreServices
//import AVFoundation
//
//class imagePickerClass: NSObject{
//    
//    //MARK:- variables
//    var isShowingVideoGallery: Bool = false
//    var isAudio = false
//    var imagePicker = UIImagePickerController()
//    var pickedImage:((UIImage,String,URL) -> ())?
//    var viewController: UIViewController?
//    var mediaPicker = MPMediaPickerController(mediaTypes: .any)
//    
//    var alert = UIAlertController(title: NSLocalizedString("Select Source", comment: ""), message: nil, preferredStyle: .actionSheet)
//    
//
//    init(_ isShowingVideoGallery:Bool,_ isAudio:Bool, _ isShowGallery:Bool){
//        super.init()
//        self.isShowingVideoGallery = isShowingVideoGallery
//        self.isAudio = isAudio
//        let openCamera = UIAlertAction(title: "Camera", style: UIAlertAction.Style.default) { (data) in
//            self.openCamera()
//        }
//       
//        let openGalary = UIAlertAction(title: "Gallery", style: .default) { (data) in
//                self.openGallery()
//        }
//        
//      
//        let openVideoGalary = UIAlertAction(title: "Video Gallery", style: .default) { (data) in
//            self.openVideoGallery()
//        }
//        
//        let openAudio = UIAlertAction(title: "Pick Audio", style: .default) { (data) in
//            self.openAudio()
//        }
//        
//        let cancelBtn = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//        alert.addAction(openCamera)
//        if isShowGallery{
//            alert.addAction(openGalary)
//        }
//       
//        if isShowingVideoGallery{
//            alert.addAction(openVideoGalary)
//        }
//        if isAudio {
//            alert.addAction(openAudio)
//        }
//        alert.addAction(cancelBtn)
//        
//    }
//    
//    //MARK:- image Picker
//    func showPicker(_ viewController: UIViewController,callback: @escaping ((UIImage,String,URL) -> ())) {
//        
//        self.viewController = viewController
//        mediaPicker.delegate = self
//        imagePicker.delegate = self
//        alert.view.tintColor = .black
//        pickedImage = callback
//        alert.popoverPresentationController?.sourceView = self.viewController!.view
//        viewController.present(alert, animated: true, completion: nil)
//        
//    }
//    
//    ///MARK:- Audio Pick
//    func openAudio(){
//        mediaPicker.allowsPickingMultipleItems = true
//        mediaPicker.showsCloudItems = true
//        mediaPicker.prompt = "Please pick a audio"
//        mediaPicker.loadView()
//        self.viewController?.present(mediaPicker, animated: true, completion: nil)
//    }
//    
//    
//    ///MARK:- Images Picker From Gallery
//    func openGallery(){
//        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
//            imagePicker.sourceType = .photoLibrary
//            imagePicker.allowsEditing = true
//            self.viewController?.present(imagePicker, animated: true, completion: nil)
//            
//        }else{
//            let alert = UIAlertController()
//            alert.title = "You don't have gallary"
//            let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
//            alert.addAction(okAction)
//            self.viewController?.present(alert, animated: true, completion: nil)
//        }
//        
//    }
//    
//    
//    ///MARK:- Images Picker From Gallery
//    func openVideoGallery(){
//        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
//            imagePicker.sourceType = .savedPhotosAlbum
//            imagePicker.mediaTypes = [kUTTypeMovie as String,kUTTypeVideo as String] //["public.movie"]
//            self.viewController?.present(imagePicker, animated: true, completion: nil)
//            
//        }else{
//            let alert = UIAlertController()
//            alert.title = "You don't have gallary"
//            
//            let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
//            
//            alert.addAction(okAction)
//            self.viewController?.present(alert, animated: true, completion: nil)
//        }
//        
//    }
//    ///MARK:- Images Picker From Camera
//    func openCamera(){
//        if UIImagePickerController.isSourceTypeAvailable(.camera){
//            imagePicker.sourceType = .camera
//            imagePicker.allowsEditing = true
////            imagePicker.mediaTypes = [kUTTypeMovie as String,kUTTypeVideo as String] //for video
//            self.viewController?.present(imagePicker, animated: true, completion: nil)
//        }else{
//            let alert = UIAlertController()
//            alert.title = "You don't have camera"
//            
//            let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
//            
//            alert.addAction(okAction)
//            self.viewController?.present(alert, animated: true, completion: nil)
//        }
//    }
//    
//    
//    //MARK:- Generate Thumanal From Url
//    func thumbnailForVideo(url: URL) -> UIImage? {
//        let asset = AVAsset(url: url)
//        let assetImageGenerator = AVAssetImageGenerator(asset: asset)
//        assetImageGenerator.appliesPreferredTrackTransform = true
//        
//        var time = asset.duration
//        time.value = min(time.value, 1)
//        
//        do {
//            let imageRef = try assetImageGenerator.copyCGImage(at: time, actualTime: nil)
//            
//            return UIImage(cgImage: imageRef)
//        } catch {
//            print("failed to create thumbnail")
//            return nil
//        }
//    }
//    
//}
//
//
//extension imagePickerClass:MPMediaPickerControllerDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate{
//    
//    //MARK:- UIImagePicker Delegate Method
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        if let img = info[.editedImage] as? UIImage{
//            self.pickedImage?(img, "image", URL(fileURLWithPath: ""))
//        }
//        else if let image = info[.originalImage] as? UIImage{
//            self.pickedImage?(image,"image",URL(fileURLWithPath: ""))
//            
//        }else if let url = info[.mediaURL] as? URL {
//            
//            if let image = self.thumbnailForVideo(url: url){
//                self.pickedImage?(image,"video", url)
//            }
//            print(url)
//        }
//        picker.dismiss(animated: true, completion:nil)
//    }
//    
//    
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        picker.dismiss(animated: true, completion: nil)
//    }
//    
//    
//    //MARK:- MPMediaPicker Controller Delegate Method
//    func mediaPicker(_ mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
//        self.viewController?.dismiss(animated: true, completion: nil)
//    }
//}
//
////Usage :
///*
// UniversalPicker(true, false).showPicker(self){ image,type,url in
// print(image)
// print(type)
// print(url)
// }
// */
//
