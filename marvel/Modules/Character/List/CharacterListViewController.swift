//
//  ListViewController.swift
//  marvel
//
//  Created by Sonia Giraldez on 14/05/2020.
//  Copyright © 2020 Sonia Giraldez. All rights reserved.
//

import Foundation
import UIKit

class CharacterListViewController: UIViewController {
    var presenter: CharacterListPresenterProtocol!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
                       
        presenter.viewDidLoad()
    }
    
    private func configureView() {
        setIconNavBar()
        tableView.register(UINib(nibName: ListConstants.kCellIdentifier,
                                 bundle: nil),
                           forCellReuseIdentifier: ListConstants.kCellIdentifier)
    }
}

//----------------------------
// MARK: - Protocol
//----------------------------
extension CharacterListViewController: CharacterListViewProtocol{
    func showData() {
        tableView.reloadData()
    }
}

//----------------------------
// MARK: - TableView configuration
//----------------------------
extension CharacterListViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.charactersToShow().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListConstants.kCellIdentifier,
                                                 for: indexPath) as! CharacterCell

        cell.configure(presenter.charactersToShow()[indexPath.row])

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(ListConstants.kCellHeight)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.selectIndex(indexPath.row)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if distanceFromBottom < height {
            presenter?.scrollBottom()
        }
    }
}

extension CharacterListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        presenter?.searchByText(searchBar.text)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        presenter?.searchByText(searchBar.text)
    }
}
