//
//  BookThumbnailTableViewCell.swift
//  BooksArchiveDemo
//
//  Created by kamalraj venkatesan on 14/08/19.
//  Copyright © 2019 kamalraj venkatesan. All rights reserved.
//

import UIKit

struct BookThumbnail {
    let bookTitle: String?
    let image: String?
    let author: String?
    let genre: String?
}

typealias BookThumbnailTableViewCellConfig = TableCellConfigurator<BookThumbnailTableViewCell, BookThumbnail>

class BookThumbnailTableViewCell: UITableViewCell, ConfigurableCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(data: BookThumbnail) {
        
    }

}
