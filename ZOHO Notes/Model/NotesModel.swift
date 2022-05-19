//
//  NotesModel.swift
//  ZOHO Notes
//
//  Created by Sai Kumar Reddy Baraju on 17/05/22.
//

import Foundation

struct Notes: Codable {
    
    var id: String
    var title: String
    var body: String
    var time: String
    var image: String?
    var imgData: Data?
    
}

