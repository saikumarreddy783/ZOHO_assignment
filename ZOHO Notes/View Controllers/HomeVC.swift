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
    var note = [Post]()
    let ApiUrl = "https://jsonplaceholder.typicode.com/posts"//"https://raw.githubusercontent.com/RishabhRaghunath/JustATest/master/posts"
 
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
        
        getNotes{ notesData in
            self.note = notesData
            DispatchQueue.main.async {
                self.notesCollectionView.reloadData()
            }
            

        }
//        getNotes { (notesData) in
//            for post in notesData{
//                print(post.title)
//            }
//        }
        
    }
    
    @IBAction func onCreateNoteBtn(_ sender: UIButton) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CreateNotesVC") as! CreateNotesVC
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    
    //MARK: - API Call
    func getNotes(completion: @escaping([Post]) -> Void){
        
    
        AF.request(ApiUrl, method: .get).validate().responseData { [self] response in
            switch response.result{
            case .success(let data):
                

                do{
                    let json = try? JSONSerialization.jsonObject(with: data) as! [NSDictionary]
                    print(json)

                    let jsonDecoder = JSONDecoder()
                    let notesData = try jsonDecoder.decode([Post].self, from: data)

                    completion(notesData)
                    
                    
                }catch{
                    
                    print("catch block")
                }


            case .failure(let error):
                print(error)
    }
    }
    }
//    func getNotes(completionHandler: @escaping([Post]) -> Void){
//        let url = URL(string: "https://raw.githubusercontent.com/RishabhRaghunath/JustATest/master/posts")!
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//            guard let data =  data else{ return }
//            do{
//                let notesData = try JSONDecoder().decode([Post].self, from: data)
//                completionHandler(notesData)
//            }catch{
//                print("this is catch block")
//
//            }
//        }.resume()
//    }
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
            cell.lblTime.text = "\(item.userId)" //"\(item.time)"
        }
        
        
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = (collectionView.frame.size.width-10)/2
        return CGSize(width: itemSize, height: itemSize)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = note[indexPath.row]
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ViewNotesVC") as! ViewNotesVC
        //nextViewController.viewImg = item.image
        nextViewController.viewBody = item.body
        nextViewController.viewTitle = item.title
        //nextViewController.viewTime = "\(item.time)"
        
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
}


