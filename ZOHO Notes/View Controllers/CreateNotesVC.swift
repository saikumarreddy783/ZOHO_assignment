//
//  CreateNotesVC.swift
//  ZOHO Notes
//
//  Created by Sai Kumar Reddy Baraju on 16/05/22.
//

import UIKit
import SkyFloatingLabelTextField

class CreateNotesVC: UIViewController {

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
    @IBOutlet weak var noteTitleTxt: SkyFloatingLabelTextField!
    @IBOutlet weak var noteBodyTxtView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onBackBtn(_ sender: UIButton) {
        _ = navigationController?.popViewController(animated: true)
    }
    @IBAction func onAttachImhBtn(_ sender: UIButton) {
    }
    @IBAction func onSaveBtn(_ sender: UIButton) {
        
    }
    
    

}
