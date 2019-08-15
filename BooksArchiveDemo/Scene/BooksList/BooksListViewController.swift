//
//  BooksListViewController.swift
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

protocol BooksListDisplayLogic: class
{
    func displayListOfBooks(viewModel: BooksList.getBooks.ViewModel)
    func handlePlaceholder(show: Bool, type: PlaceholderType?)
    func handleLoader(show: Bool)
}

class BooksListViewController: UIViewController, BooksListDisplayLogic
{
    
    // MARK: UIObject
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var placeholderView: PlaceholderView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    
    var interactor: BooksListBusinessLogic?
    var router: (NSObjectProtocol & BooksListRoutingLogic & BooksListDataPassing)?
    
    var getBooksViewModel: BooksList.getBooks.ViewModel? {
        didSet {
            guard getBooksViewModel != nil else {
                self.tableView.isHidden = true
                return
            }
            self.title = getBooksViewModel?.title
            self.tableView.isHidden = false
            self.tableView.reloadData()
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
        let interactor = BooksListInteractor()
        let presenter = BooksListPresenter()
        let router = BooksListRouter()
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
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllBooks()
        removeEmptyRows()
    }
    
    // MARK: Helper
    private func removeEmptyRows() {
        self.tableView.tableFooterView = UIView()
    }
    
    // MARK: Get Books
    func getAllBooks()
    {
        let request = BooksList.getBooks.Request()
        interactor?.getBooks(request: request)
    }
    
    func displayListOfBooks(viewModel: BooksList.getBooks.ViewModel) {
        self.getBooksViewModel = viewModel
    }
    
    func handlePlaceholder(show: Bool, type: PlaceholderType?) {
        
        self.placeholderView.isHidden = !show
        self.placeholderView.type = type
    }
    
    func handleLoader(show: Bool) {
        show ? self.activityIndicator.startAnimating() : self.activityIndicator.stopAnimating()
    }
    
    // MARK: Action
    @IBAction func refreshBooksList(sender: UIBarButtonItem) {
        interactor?.getBooks(request: BooksList.getBooks.Request())
    }
    
    @IBAction func showFilters(sender: UIBarButtonItem) {
        router?.showFirstStepFilter()
    }
}


extension BooksListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.getBooksViewModel?.cells.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = self.getBooksViewModel!.cells[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: type(of: item).reuseId, for: indexPath)
        
        item.configure(cell: cell)
        
        return cell
    }
}

extension BooksListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.navigateToDetailView(index: indexPath.row)
    }
}
