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

class ViewNotesVC: UIViewController {

    @IBOutlet weak var backBtn: UIButton!{
        didSet{
            backBtn.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var noteImageHeight: NSLayoutConstraint!
    @IBOutlet weak var noteImage: UIImageView!
    @IBOutlet weak var noteTitleLbl: UILabel!
    @IBOutlet weak var notetimeLbl: UILabel!
    @IBOutlet weak var noteBodyLbl: UILabel!
    
    var viewImg = ""
    var viewTitle = ""
    var viewTime = ""
    var viewBody = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if let imgurl = item.categoryImage{
//            loadImage(ImageView: cell.img_Categories, imagePath: imgurl)
//        }
        
//        if noteImage.image != nil{
//            noteImageHeight.constant = 170
//            noteImage.image = viewImg
//
//        }else{
//            noteImageHeight.constant = 0
//        }
        
        
        noteTitleLbl.text = viewTitle
        notetimeLbl.text = "\(viewTime)"
        noteBodyLbl.text = viewBody
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onBackBtn(_ sender: UIButton) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    
}


func loadImage(ImageView: UIImageView, imagePath: String){
    if imagePath != ""{
        //ImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        ImageView.sd_setImage(with: URL(string: imagePath), placeholderImage: UIImage(named: ""), options: SDWebImageOptions.refreshCached, context: nil)
        //ImageView.sd_setImage(with: , placeholderImage: )
         ImageView.pin_updateWithProgress = true
        ImageView.pin_setImage(from:  URL(string: imagePath), placeholderImage: nil)
        //ImageView.pin_setImage(from: URL(string: imagePath)!)
        //ImageView.kf.indicatorType = .activity
        //ImageView.kf.setImage(with: URL(string: imagePath), placeholder: UIImage(named: "ic_placeholder_1"))
    }else{
        ImageView.image = UIImage(named: "")  // ic_placeholder_1
        ImageView.backgroundColor = UIColor.white
    }
}

