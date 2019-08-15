//
//  BooksListInteractor.swift
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

protocol BooksListBusinessLogic
{
    func getBooks(request: BooksList.getBooks.Request)
    var filterAuthor: filterClosure { get set }
    var filterGenre: filterClosure { get set }
    var filterCountry: filterClosure { get set }
}

protocol BooksListDataStore
{
    var books: [Book]? { get set }
    var authors: Set<String> { get }
    var genre: Set<String> { get }
    var countries: Set<String> { get }
}

class BooksListInteractor: BooksListBusinessLogic, BooksListDataStore
{
    var presenter: BooksListPresentationLogic?
    var worker: BooksListWorker?
    
    var books: [Book]?
    
    var authors: Set<String> {
        get {
            return Set(books?.compactMap{ $0.author_name ?? nil } ?? []) 
        }
    }
    
    var genre: Set<String> {
        get {
            return Set(books?.compactMap{ $0.genre ?? nil } ?? [])
        }
    }
    
    var countries: Set<String> {
        get {
            return Set(books?.compactMap{ $0.author_country ?? nil } ?? [] )
        }
    }
    
    // MARK: Get Books
    func getBooks(request: BooksList.getBooks.Request)
    {
        presenter?.presentLoader(show: true)
        
        worker = BooksListWorker()
        worker?.getAllBooks(completion: { [weak self] (books, error, statusCode) in
            
            self?.presenter?.presentLoader(show: false)
            
            self?.books = books
            
            guard error == nil, books != nil else {
                // Error
                self?.presenter?.presentPlaceholder(show: true, type: (error == BookssAppErrors.NoInternet) ? PlaceholderType.noInternet : PlaceholderType.somethingWentWrong )
                return
            }
            
            guard !books!.isEmpty else {
                // Books List is Empty
                self?.presenter?.presentPlaceholder(show: true, type: .noResult)
                return
            }
            
            // Books Available
            self?.presenter?.presentPlaceholder(show: false, type: nil) // Hiding Placeholder view
            
            let response = BooksList.getBooks.Response(books: books!, filteredByAuthor: nil, filteredByGenre: nil, filteredByCountry: nil)
            self?.presenter?.presentBooks(response: response)
        })
    }
    
    // MARK: Filter
    lazy var filterAuthor: filterClosure = { [weak self] (searchKey) in
        
        let filteredBooks = self?.books?.filter{ $0.author_name == searchKey }
        
        let response = BooksList.getBooks.Response(books: filteredBooks ?? [], filteredByAuthor: searchKey, filteredByGenre: nil, filteredByCountry: nil)
        self?.presenter?.presentBooks(response: response)
    }
    
    lazy var filterGenre: filterClosure = { [weak self] (searchKey) in
        
        let filteredBooks = self?.books?.filter{ $0.genre == searchKey }
        
        let response = BooksList.getBooks.Response(books: filteredBooks ?? [], filteredByAuthor: nil, filteredByGenre: searchKey, filteredByCountry: nil)
        self?.presenter?.presentBooks(response: response)
    }
    
    lazy var filterCountry: filterClosure = { [weak self] (searchKey) in
        
        let filteredBooks = self?.books?.filter{ $0.author_country == searchKey }
        
        let response = BooksList.getBooks.Response(books: filteredBooks ?? [], filteredByAuthor: nil, filteredByGenre: nil, filteredByCountry: searchKey)
        self?.presenter?.presentBooks(response: response)
    }
}
