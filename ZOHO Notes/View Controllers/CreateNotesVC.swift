//
//  CreateNotesVC.swift
//  ZOHO Notes
//
//  Created by Sai Kumar Reddy Baraju on 16/05/22.
//

import UIKit
import SkyFloatingLabelTextField
import Kingfisher
import Photos
import MobileCoreServices

class CreateNotesVC: UIViewController {
    
    var pickedNotesImage:Data = Data()
    
    @IBOutlet weak var backBtn: UIButton!{
        didSet{
            backBtn.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var attachImgBtn: UIButton!{
        didSet{
            attachImgBtn.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var saveBtn: UIButton!{
        didSet{
            saveBtn.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var noteTitleTxt: UITextField!
    @IBOutlet weak var noteBodyTxtView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func onBackBtn(_ sender: UIButton) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onAttachImhBtn(_ sender: UIButton) {
        let actionSheet = UIAlertController(title: "Select Option", message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action) -> Void in
            self.openCamera()
        }))
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action) -> Void in
            self.checkPhotoLibraryPermission()
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    
    
    @IBAction func onSaveBtn(_ sender: UIButton) {
        if noteTitleTxt.text != ""{
        var noteId = HomeVC()
        let date = Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        let todayDate = dateFormatter.string(from: date)
        
        let DateTime = "\(todayDate)"
        
        var note = Notes(id: "\(noteId.note.count+1)", title: noteTitleTxt.text ?? "", body: noteBodyTxtView.text ?? "", time: DateTime ?? "", image: nil,  imgData: pickedNotesImage)
        PersistanceService.shared.saveNotesData(note: note)
        
        _ = navigationController?.popViewController(animated: true)
        }else{
            showAlertMsg(Message: "Please add Title and Body or Image", AutoHide: false)
            
        }
    }
    
    
    
    func checkPhotoLibraryPermission() {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status{
        case .authorized:
            self.openPhotoLibrary()
        case .denied, .restricted:
            self.alertForAccessNeeded()
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({ (status) in
                if status == PHAuthorizationStatus.authorized{
                    self.openPhotoLibrary()
                }
            })
        default:
            break
        }
    }
    
    func alertForAccessNeeded() {
        let settingsAppURL = URL(string: UIApplication.openSettingsURLString)!
        let alertController = Alertview(title: "Need Permission", body: "Photo Library or Camera access is required.", cancelbutton: "Cancel", okbutton: "Change Permission") {
            UIApplication.shared.open(settingsAppURL, options: [:], completionHandler: nil)
        }
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    
}


// MARK: - ImagePickerController Delegate and NavigationController Delegate
extension CreateNotesVC:UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    func openCamera(){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            
            showAlertMsg(Message: "Camera not available on this device", AutoHide: false)
        }
    }
    
    func openPhotoLibrary(){
        DispatchQueue.main.async {
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .photoLibrary
                imagePicker.mediaTypes = [kUTTypeImage as String]
                self.present(imagePicker, animated: true, completion: nil)
            } else {
                
                showAlertMsg(Message: "Photo Library not available on this device", AutoHide: false)
            }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            pickedNotesImage = pickedImage.jpegData(compressionQuality: 0.75)!
            
            self.attachImgBtn.layer.backgroundColor = UIColor(red: 104/255, green: 187/255, blue: 89/255, alpha: 1.0).cgColor
            showAlertMsg(Message: "Image added sucessfully", AutoHide: true)
            
        }
        picker.dismiss(animated: true, completion: nil)
    }
}


//MARK: - ShowAlert popup 
func showAlertMsg(Message: String, AutoHide:Bool) -> Void
{
    DispatchQueue.main.async
    {
        let alert = UIAlertController(title: "", message: Message, preferredStyle: UIAlertController.Style.alert)
        
        if AutoHide == true
        {
            //alert.dismiss(animated: true, completion:nil)
            
            let deadlineTime = DispatchTime.now() + .seconds(2)
            DispatchQueue.main.asyncAfter(deadline: deadlineTime)
            {
                print("Alert Dismiss")
                alert.dismiss(animated: true, completion:nil)
            }
        }
        else
        {
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            
        }
        UIApplication.shared.windows[0].rootViewController?.present(alert, animated: true, completion: nil)
    }
}


//MARK: - function for showing alert popup for permissions
func Alertview(title: String, body: String, cancelbutton: String, okbutton: String, completion:@escaping () -> Void) -> UIAlertController {
    let alertController = UIAlertController(title: title, message: body, preferredStyle: .alert)
    
    
    // Create the actions
    let cancelAction = UIAlertAction(title: cancelbutton, style: UIAlertAction.Style.cancel) {
        UIAlertAction in
    }
    
    let okAction = UIAlertAction(title: okbutton, style: UIAlertAction.Style.default) {
        UIAlertAction in
        completion()
    }
    // Add the actions
    alertController.addAction(okAction)
    if cancelbutton != ""{
        alertController.addAction(cancelAction)
    }
    return alertController
}


