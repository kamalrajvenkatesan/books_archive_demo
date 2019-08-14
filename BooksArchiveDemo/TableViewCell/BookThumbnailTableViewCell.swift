//
//  BookThumbnailTableViewCell.swift
//  BooksArchiveDemo
//
//  Created by kamalraj venkatesan on 14/08/19.
//  Copyright © 2019 kamalraj venkatesan. All rights reserved.
//

import UIKit
import AlamofireImage

struct BookThumbnail {
    let bookTitle: String?
    let image: String?
    let author: String?
    let genre: String?
}

typealias BookThumbnailTableViewCellConfig = TableCellConfigurator<BookThumbnailTableViewCell, BookThumbnail>

class BookThumbnailTableViewCell: UITableViewCell, ConfigurableCell {
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleContainerView: UIView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(data: BookThumbnail) {
        
        if let url = URL(string: data.image ?? "") {
            bookImageView.af_setImage(withURL: url)
        } else {
            bookImageView.image = nil
        }
        
        titleLabel.text = data.bookTitle
        authorLabel.text = data.author
        genreLabel.text = data.genre
        
    }

}
