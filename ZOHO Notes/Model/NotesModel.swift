//
//  NotesModel.swift
//  ZOHO Notes
//
//  Created by Sai Kumar Reddy Baraju on 17/05/22.
//

import Foundation


struct Post: Codable {

    var userId: Int
    var id: Int
    var title: String
    var body: String
}

//struct Notes: Codable {
//
//    var body: String
//    var id: Int
//    var image: String?
//    var time: Int32
//    var title: String

//    init(from decoder: Decoder) throws {
//        var values = try decoder.unkeyedContainer()
//        self.body = try values.decode(String.self)
//        self.id = try values.decode(Int.self)
//        self.image = try values.decode(String.self)
//        self.time = try values.decode(Int32.self)
//        self.title = try values.decode(String.self)
//    }

//}

//struct Notes {
//    var body: String
//    var id: Int
//    var image: String?
//    var time: Int32
//    var title: String
//
//
//    init(body: String, id: Int, image: String, time: Int32, title: String) {
//        self.body = body
//        self.id = id
//        self.image = image
//        self.time = time
//        self.title = title
//  }
//}

