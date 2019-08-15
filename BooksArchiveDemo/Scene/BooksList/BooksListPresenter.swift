//
//  BooksListPresenter.swift
//  BooksArchiveDemo
//
//  Created by kamalraj venkatesan on 14/08/19.
//  Copyright (c) 2019 kamalraj venkatesan. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol BooksListPresentationLogic
{
    func presentBooks(response: BooksList.getBooks.Response)
    func presentPlaceholder(show: Bool, type: PlaceholderType?)
    func presentLoader(show: Bool)
}

class BooksListPresenter: BooksListPresentationLogic
{
    weak var viewController: BooksListDisplayLogic?
    
    
    
    // MARK: Present Book
    func presentBooks(response: BooksList.getBooks.Response)
    {
        
        var cellConfigs: [CellConfigurator] {
            return response.books.map{ BookThumbnailTableViewCellConfig.init(data: $0.getBookThumbnail()) }
        }
        
        var title: String {
            
            if let author = response.filteredByAuthor {
                return "Authored by \(author)"
            } else if let genre = response.filteredByGenre {
                return "Genre of \(genre)"
            } else if let country = response.filteredByCountry {
                return "List of books from country \(country)"
            } else {
                return "Books Archive"
            }
            
        }
        
        let viewModel = BooksList.getBooks.ViewModel(cells: cellConfigs, title: title)
        viewController?.displayListOfBooks(viewModel: viewModel)
    }
    
    func presentPlaceholder(show: Bool, type: PlaceholderType?) {
        viewController?.handlePlaceholder(show: show, type: type)
    }
    
    func presentLoader(show: Bool) {
        viewController?.handleLoader(show: show)
    }
}
