//
//  ViewController.swift
//  mars
//
//  Created by mars uzhanov on 20.02.2024.
//

import UIKit
import SnapKit
import UIScrollView_InfiniteScroll

class SearchViewController: UIViewController {
    
    var network = APICaller.shared
    var booksResults: [Books.Items] = []
    var isLoading = false
    var currentPage = 1
    
    //MARK: - Private properties
    private lazy var searchBar: UISearchBar = {
        let search = UISearchBar()
        search.delegate = self
        search.placeholder = "Search"
        return search
    }()
    
    private lazy var bookTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 100
        tableView.register(BooksTableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.titleView = searchBar
        network.delegate = self
        setupUI()
        network.fetchBooks(query: "mars")
        infiniteScroll()
        
    }
    
    //MARK: - Infinite scroll on bookTableView
    func infiniteScroll() {
        bookTableView.infiniteScrollDirection = .vertical
        bookTableView.addInfiniteScroll { [self] table in
            isLoading = true
            if searchBar.text == "" {
                network.fetchBooks(query: "mars", page: currentPage)
            } else {
                network.fetchBooks(query: searchBar.text!, page: currentPage)
            }
            currentPage += 1
            DispatchQueue.main.async { [self] in
                bookTableView.reloadData()
            }
            table.finishInfiniteScroll()
        }
    }
    
    //    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    //        let offsetY = scrollView.contentOffset.y
    //        let contentHeight = scrollView.contentSize.height
    //        let screenHeight = scrollView.frame.size.height
    //
    //        if offsetY > contentHeight - screenHeight && !isLoading {
    ////            loadData()
    //        }
    //    }
    
    //MARK: - NavigationController
    func showDetails(for book: Books.Items) {
        let detailsVC = DetailsViewController()
        detailsVC.book = book
        UIView.transition(with: navigationController!.view, duration: 0.5, options: .transitionCrossDissolve, animations: {
                self.navigationController?.pushViewController(detailsVC, animated: false)
            }, completion: nil)
    }
    
}

//MARK: - Private methods
private extension SearchViewController {
    
    func setupUI() {
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        view.addSubview(bookTableView)
    }
    
    func setupConstraints() {
        bookTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        booksResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BooksTableViewCell
        cell.configure(with: booksResults[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let book = booksResults[indexPath.row]
        showDetails(for: book)
    }
    
}

//MARK: - NetworkManagerDelegate
extension SearchViewController: NetworkManagerDelegate {
    func didUpdateBooks(with results: [Books.Items]) {
        if isLoading {
            booksResults.append(contentsOf: results)
            isLoading = false
        } else {
            self.booksResults = results
        }
        DispatchQueue.main.async { [self] in
            bookTableView.reloadData()
        }
    }
    
    //    func loadMoreBooks(with results: [Books.Items]) {
    //        booksResults.append(contentsOf: results)
    //        isLoading = false
    //        DispatchQueue.main.async { [self] in
    //            bookTableView.reloadData()
    //        }
    //    }
    
    func didFailWithError(_ error: Error) {
        print(error)
    }
    
}

//MARK: - UISeachBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            network.fetchBooks(query: searchText)
            currentPage = 1
        }
        let indexPath = IndexPath(row: 0, section: 0)
        bookTableView.scrollToRow(at: indexPath, at: .top, animated: true)
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
}
