//
//  NotesCVCellCollectionViewCell.swift
//  ZOHO Notes
//
//  Created by Sai Kumar Reddy Baraju on 16/05/22.
//

import UIKit

class NotesCVCellCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var backView: UIView!{
        didSet{
            backView.layer.cornerRadius = 10
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
