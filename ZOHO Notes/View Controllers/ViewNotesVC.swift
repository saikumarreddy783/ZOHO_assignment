//
//  ViewNotesVC.swift
//  ZOHO Notes
//
//  Created by Sai Kumar Reddy Baraju on 16/05/22.
//

import UIKit
import Foundation
import SDWebImage
import Kingfisher
import PINRemoteImage

class ViewNotesVC: UIViewController, UITextViewDelegate {
    @IBOutlet weak var deleteNotesBtn: UIButton!{
        didSet{
            deleteNotesBtn.layer.cornerRadius = 10
        }
    }
    
    @IBOutlet weak var backBtn: UIButton!{
        didSet{
            backBtn.layer.cornerRadius = 10
        }
    }
    
    @IBOutlet weak var noteImageHeight: NSLayoutConstraint!
    @IBOutlet weak var noteImage: UIImageView!
    @IBOutlet weak var noteTitleLbl: UILabel!
    @IBOutlet weak var notetimeLbl: UILabel!
    @IBOutlet weak var noteBodyTextView: UITextView!
    
    var noteDetail: Notes!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let image = noteDetail.image{
            noteImage.isHidden = false
            noteImageHeight.constant = 170
            loadImage(ImageView: noteImage, imagePath: image)
        }else if let image = noteDetail.imgData{
            noteImage.isHidden = false
            noteImageHeight.constant = 170
            noteImage.image = UIImage(data: image)
        }else{
            noteImage.isHidden = true
            noteImageHeight.constant = 0
            
        }
        self.getLocalTime()
        
        noteTitleLbl.text = noteDetail.title
        
        
        //MARK: - tap on Image
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        noteImage.isUserInteractionEnabled = true
        noteImage.addGestureRecognizer(tapGestureRecognizer)
        
        //MARK: - for creating link in the text,
        let not = "\(noteDetail.body)"
        
        let keyword = not.slice(from: "[", to: "]")
        print("sai")
        print(keyword ?? "")
        
        let linkUrl = not.slice(from: "(", to: ")") ?? ""
        print("sai")
        let textWithoutlink = not.replacingOccurrences(of: linkUrl, with: "")
        var textWithoutlink2 = textWithoutlink.replacingOccurrences(of: "()", with: "")
        
        //print(linkUrl ?? "")
        
        //MARK: - for creating link in the text
        func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
            if (URL.absoluteString == linkUrl) {
                UIApplication.shared.open(URL) { (Bool) in
                }
            }
            return false
        }
        
        if keyword != "" || linkUrl != ""{
            noteBodyTextView.hyperLink(originalText: textWithoutlink2, hyperLink: keyword ?? "", urlString: linkUrl ?? "")
        }else{
            noteBodyTextView.text = noteDetail.body
        }
        
    }
    
    
    
    
    //MARK: - function for image expansion
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        let newImageView = UIImageView(image: tappedImage.image)
        newImageView.frame = UIScreen.main.bounds
        newImageView.backgroundColor = .black
        newImageView.contentMode = .scaleAspectFit
        newImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        newImageView.addGestureRecognizer(tap)
        self.view.addSubview(newImageView)
        //self.navigationController?.isNavigationBarHidden = true
        //self.tabBarController?.tabBar.isHidden = true
    }
    
    //MARK: - function for closing image expansion
    @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        sender.view?.removeFromSuperview()
    }
    
    
    @IBAction func onBackBtn(_ sender: UIButton) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func delNoteBtnAction(_ sender: UIButton) {
        if let item = PersistanceService.savedNotes().filter({$0.note_title == noteDetail.title}).first{
            PersistanceService.shared.context.delete(item)
            PersistanceService.shared.saveContext()
            _ = navigationController?.popViewController(animated: true)
        }
        
    }
    
    //MARK: - convert time to Local
    func getLocalTime(){
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        if noteDetail.time.contains(","){
            notetimeLbl.text = noteDetail.time
            
        }else{
            
            let dateValue = Double(noteDetail.time)
            
            var dateLbl = NSDate(timeIntervalSince1970: dateValue ?? 0)
            notetimeLbl.text = "\(dateFormatter.string(from: dateLbl as Date))"
        }
        
    }
}

//MARK: - load Image from URl
func loadImage(ImageView: UIImageView, imagePath: String){
    if imagePath != ""{
        
        ImageView.sd_setImage(with: URL(string: imagePath), placeholderImage: UIImage(named: ""), options: SDWebImageOptions.refreshCached, context: nil)
        ImageView.pin_updateWithProgress = true
        ImageView.pin_setImage(from:  URL(string: imagePath), placeholderImage: nil)
    }else{
        ImageView.image = UIImage(named: "")
        ImageView.backgroundColor = UIColor.white
    }
}

extension UITextView {
    func hyperLink(originalText: String,
                   hyperLink: String,
                   urlString: String,
                   withFont font: UIFont = UIFont.systemFont(ofSize: 20.0),
                   textColor: UIColor = .gray,
                   linkColor: UIColor = UIColor(red: 8/255, green: 143/255, blue: 143/255, alpha: 1.0)) {
        isEditable = false
        
        let style = NSMutableParagraphStyle()
        style.alignment = .left
        
        let attributedOriginalText = NSMutableAttributedString(string: originalText)
        let linkRange = attributedOriginalText.mutableString.range(of: hyperLink)
        let fullRange = NSMakeRange(0, attributedOriginalText.length)
        attributedOriginalText.addAttribute(NSAttributedString.Key.link, value: urlString, range: linkRange)
        attributedOriginalText.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: fullRange)
        attributedOriginalText.addAttribute(NSAttributedString.Key.foregroundColor, value: textColor, range: fullRange)
        attributedOriginalText.addAttribute(NSAttributedString.Key.font, value: font, range: fullRange)
        
        self.linkTextAttributes = [
            NSAttributedString.Key.foregroundColor.rawValue: linkColor,
            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
        ] as? [NSAttributedString.Key: Any]
        
        self.attributedText = attributedOriginalText
    }
}

extension String {
    
    func slice(from: String, to: String) -> String? {
        return (range(of: from)?.upperBound).flatMap { substringFrom in
            (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                String(self[substringFrom..<substringTo])
            }
        }
    }
}
