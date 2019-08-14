//
//  Book.swift
//  BooksArchiveDemo
//
//  Created by kamalraj venkatesan on 14/08/19.
//  Copyright © 2019 kamalraj venkatesan. All rights reserved.
//

import Foundation

public struct Book: Codable {
    let id: String
    let book_title: String
    let author_name: String?
    let genre: String?
    let publisher: String?
    let author_country: String?
    let sold_count: Int?
    let image_url: String?
}
