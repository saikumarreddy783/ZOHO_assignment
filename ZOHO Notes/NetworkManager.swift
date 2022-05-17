//
//  NetworkManager.swift
//  ZOHO Notes
//
//  Created by Sai Kumar Reddy Baraju on 16/05/22.
//

import Alamofire
import Foundation
import SVProgressHUD




class NetworkManager {
    
    let ApiUrl = "https://raw.githubusercontent.com/RishabhRaghunath/JustATest/master/posts"
    
//    func getNotes(completion: @escaping([Notes]) -> Void){
//        AF.request(ApiUrl, method: .get).validate().responseData { response in
//            switch response.result{
//            case .success(let data):
//                let jsonDecoder = JSONDecoder()
//                if let note = try?jsonDecoder.decode(Notes.self, from: data){
//                    
//                    completion(note)
//                }
//
//
//            case .failure(let error):
//                print(error)
//    }
//    }
//    }

}
