//
//  BookDetailViewController.swift
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

protocol BookDetailDisplayLogic: class
{
    func displaySomething(viewModel: BookDetail.ShowBook.ViewModel)
}

class BookDetailViewController: UIViewController, BookDetailDisplayLogic
{
    
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    
    var interactor: BookDetailBusinessLogic?
    var router: (NSObjectProtocol & BookDetailRoutingLogic & BookDetailDataPassing)?
    
    var book: Book?
    
    var viewModel: BookDetail.ShowBook.ViewModel? {
        didSet {
            if let urlString = viewModel?.imageUrl, let url = URL(string: urlString) {
                bookImageView.af_setImage(withURL: url)
            } else {
                bookImageView.image = nil
            }
            self.title = viewModel?.title
            authorLabel.text = viewModel?.author
            genreLabel.text = viewModel?.genre
        }
    }
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup()
    {
        let viewController = self
        let interactor = BookDetailInteractor()
        let presenter = BookDetailPresenter()
        let router = BookDetailRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        doSomething()
    }
    
    // MARK: Do something
    func doSomething() {
        let request = BookDetail.ShowBook.Request(book: self.book)
        interactor?.doSomething(request: request)
    }
    
    func displaySomething(viewModel: BookDetail.ShowBook.ViewModel) {
        self.viewModel = viewModel
    }
}