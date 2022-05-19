//
//  HomeVC.swift
//  ZOHO Notes
//
//  Created by Sai Kumar Reddy Baraju on 16/05/22.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

class HomeVC: UIViewController {
    
    
    //MARK: - Variables
    var note = [Notes]()
    let ApiUrl = "https://raw.githubusercontent.com/RishabhRaghunath/JustATest/master/posts"
    
    //MARK: - Outlets
    @IBOutlet weak var notesCollectionView: UICollectionView!{
        didSet{
            self.notesCollectionView.register(UINib(nibName: "NotesCVCellCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "NotesCVCellCollectionViewCell")
            
            self.notesCollectionView.dataSource = self
            self.notesCollectionView.delegate = self
        }
    }
    @IBOutlet weak var createNoteBtn: UIButton!{
        didSet{
            self.createNoteBtn.layer.cornerRadius = createNoteBtn.frame.size.width/2
            self.createNoteBtn.layer.shadowRadius = 4
            createNoteBtn.layer.masksToBounds = false
            createNoteBtn.layer.shadowColor = UIColor.white.cgColor
            createNoteBtn.layer.shadowOpacity = 0.2
            createNoteBtn.layer.shadowOffset = .zero
            createNoteBtn.layer.shouldRasterize = true
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getNotes{ [self] notesData in
            note = []
            self.note = notesData
            note += PersistanceService.shared.getLocalSavedNotes()
            DispatchQueue.main.async {
                self.notesCollectionView.reloadData()
            }
        }
    }
    
    @IBAction func onCreateNoteBtn(_ sender: UIButton) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CreateNotesVC") as! CreateNotesVC
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    
    //MARK: - API Call
    func getNotes(completion: @escaping([Notes]) -> Void){
        
        AF.request(ApiUrl, method: .get).validate().responseData { [self] response in
            switch response.result{
            case .success(let data):
                do{
                    let json = try? JSONSerialization.jsonObject(with: data) as! [NSDictionary]
                    print(json)
                    
                    let jsonDecoder = JSONDecoder()
                    let notesData = try jsonDecoder.decode([Notes].self, from: data)
                    
                    completion(notesData)
                    
                }catch{
                    print("catch block")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}



extension HomeVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.note.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = notesCollectionView.dequeueReusableCell(withReuseIdentifier: "NotesCVCellCollectionViewCell", for: indexPath) as! NotesCVCellCollectionViewCell
        
        if note.count > 0{
            let item = note[indexPath.row]
            cell.lblTitle.text = item.title
            
            //MARK: - convert time to Local
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            
            if item.time.contains(","){
                cell.lblTime.text = item.time
                
            }else{
                
                let dateValue = Double(item.time)
                
                var dateLbl = NSDate(timeIntervalSince1970: dateValue ?? 0)
                cell.lblTime.text = "\(dateFormatter.string(from: dateLbl as Date))"
            }
        }
        
        switch indexPath.row{
        case 0:
            cell.backView.backgroundColor = UIColor(red: 243/255, green: 206/255, blue: 206/255, alpha: 1.0)
            
        case 1:
            cell.backView.backgroundColor = UIColor(red: 255/255, green: 238/255, blue: 211/255, alpha: 1.0)
            
        case 2:
            cell.backView.backgroundColor = UIColor(red: 197/255, green: 246/255, blue: 185/255, alpha: 1.0)
            
        case 3:
            cell.backView.backgroundColor = UIColor(red: 255/255, green: 117/255, blue: 97/255, alpha: 1.0)
            
        case 4:
            cell.backView.backgroundColor = UIColor(red: 162/255, green: 255/255, blue: 237/255, alpha: 1.0)
            
        case 5:
            cell.backView.backgroundColor = UIColor(red: 198/255, green: 133/255, blue: 214/255, alpha: 1.0)
            
        case 6:
            cell.backView.backgroundColor = UIColor(red: 137/255, green: 207/255, blue: 15/255, alpha: 1.0)
            
        case 7:
            cell.backView.backgroundColor = UIColor(red: 153/255, green: 238/255, blue: 153/255, alpha: 1.0)
            
        case 8:
            cell.backView.backgroundColor = UIColor(red: 153/255, green: 153/255, blue: 204/255, alpha: 1.0)
        case 9:
            cell.backView.backgroundColor = UIColor(red: 243/255, green: 206/255, blue: 206/255, alpha: 1.0)
            
        case 10:
            cell.backView.backgroundColor = UIColor(red: 255/255, green: 238/255, blue: 211/255, alpha: 1.0)
            
        case 11:
            cell.backView.backgroundColor = UIColor(red: 197/255, green: 246/255, blue: 185/255, alpha: 1.0)
            
        case 12:
            cell.backView.backgroundColor = UIColor(red: 255/255, green: 117/255, blue: 97/255, alpha: 1.0)
            
        case 13:
            cell.backView.backgroundColor = UIColor(red: 162/255, green: 255/255, blue: 237/255, alpha: 1.0)
            
        case 14:
            cell.backView.backgroundColor = UIColor(red: 198/255, green: 133/255, blue: 214/255, alpha: 1.0)
            
        case 15:
            cell.backView.backgroundColor = UIColor(red: 137/255, green: 207/255, blue: 15/255, alpha: 1.0)
            
        case 16:
            cell.backView.backgroundColor = UIColor(red: 153/255, green: 238/255, blue: 153/255, alpha: 1.0)
            
        case 8:
            cell.backView.backgroundColor = UIColor(red: 153/255, green: 153/255, blue: 204/255, alpha: 1.0)
            
        default:
            cell.backView.backgroundColor = UIColor(red: 243/255, green: 206/255, blue: 206/255, alpha: 1.0)
            
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = note[indexPath.row]
        
        var itemSize = (collectionView.frame.size.width-10)/2
        
        if (item.image != nil) || item.imgData != nil{
            itemSize = collectionView.frame.size.width-10
            var itemsizeheight = (collectionView.frame.size.height-10)/3.5
            return CGSize(width: itemSize, height: itemsizeheight)
            
        }
        return CGSize(width: itemSize, height: itemSize)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = note[indexPath.row]
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ViewNotesVC") as! ViewNotesVC
        
        nextViewController.noteDetail = item
        
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
}


