//
//  BooksListRouter.swift
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

@objc protocol BooksListRoutingLogic {
    func navigateToDetailView(index: Int)
    func showFirstStepFilter()
}

protocol BooksListDataPassing
{
    var dataStore: BooksListDataStore? { get }
}

class BooksListRouter: NSObject, BooksListRoutingLogic, BooksListDataPassing
{
    weak var viewController: BooksListViewController?
    var dataStore: BooksListDataStore?
    
    // MARK: Routing
    func navigateToDetailView(index: Int) {
        
        guard let book = dataStore?.books?[index] else {
            return
        }
        
        let vc = self.viewController?.storyboard?.instantiateViewController(withIdentifier: "BookDetailViewController") as! BookDetailViewController
        vc.book = book
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: Action Sheet
    func showFirstStepFilter() {
        
        guard dataStore?.books != nil else {
            return
        }
        
        let actionController = UIAlertController(title: "Filter by", message: nil, preferredStyle: .actionSheet)
        
        let actions: [UIAlertAction] = [
            UIAlertAction(title: "Author", style: .default, handler: { _ in
                self.showFilterAlert(title: "Author", key: "author_name", actionName: self.dataStore?.authors ?? [])
            }),
            UIAlertAction(title: "Genre", style: .default, handler: { _ in
                self.showFilterAlert(title: "Genre", key: "genre", actionName: self.dataStore?.genre ?? [])
            }),
            UIAlertAction(title: "Country", style: .default, handler: { _ in
                self.showFilterAlert(title: "Country", key: "author_country", actionName: self.dataStore?.countries ?? [])
            }),
            UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        ]
        
        actions.forEach{ actionController.addAction($0) }
        
        self.viewController?.present(actionController, animated: true, completion: nil)
    }
    
    
    private func showFilterAlert(title: String, key: String, actionName: Set<String>) {
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
        
        var actions: [UIAlertAction] = actionName.compactMap{ value in
            UIAlertAction(title: value, style: .default,
                          handler: { _ in
                            if key == "author_name" {
                                self.viewController?.interactor?.filterAuthor(value)
                            } else if key == "genre" {
                                self.viewController?.interactor?.filterGenre(value)
                            } else if key == "author_country" {
                                self.viewController?.interactor?.filterCountry(value)
                            }
            })
        }
        
        actions.append(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        actions.forEach{ alertController.addAction($0) }
        
        self.viewController?.present(alertController, animated: true, completion: nil)
        
    }
}
