//
//  AuthorModel.swift
//  DemoTask
//
//  Created by MacMini-dev on 24/05/23.
//

import Foundation

// MARK: - AuthorModel
struct AuthorModel: Decodable {
    let id, author: String
    let url, downloadURL: String
    var isSelected: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id, author, url
        case downloadURL = "download_url"
    }
    
}
