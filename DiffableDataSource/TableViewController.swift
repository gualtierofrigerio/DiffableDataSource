//
//  TableViewController.swift
//  DiffableDataSource
//
//  Created by Gualtiero Frigerio on 05/09/2019.
//  Copyright © 2019 Gualtiero Frigerio. All rights reserved.
//

import UIKit

enum Section {
    case main
}

class TableViewController: UITableViewController {

    let cellIdentifier = "cellIdentifier"
    var dataSource:DataSource?
    var tableDataSource:UITableViewDiffableDataSource<Section, Beer>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDataSource()
        configureSearchViewController()
        dataSource?.getBeers(page: 1, completion: { [weak self] beers in
            if let beers = beers {
                self?.updateDataSource(withBeers: beers, animated: false)
            }
        })
    }
}

//MARK: - Table view

extension TableViewController {
    private func configureDataSource() {
        tableDataSource = UITableViewDiffableDataSource<Section, Beer>(tableView: self.tableView, cellProvider: { (tableView, indexPath, beer) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier)
            cell?.textLabel?.text = beer.name
            cell?.detailTextLabel?.text = beer.description
            return cell
        })
    }
    
    private func updateDataSource(withBeers beers:[Beer], animated:Bool) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Beer>()
        snapshot.appendSections([.main])
        snapshot.appendItems(beers, toSection: .main)
        tableDataSource.apply(snapshot, animatingDifferences: animated)
    }
}

//MARK: - UISearchResultsUpdating

extension TableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            applyFilter(searchText)
        }
        else {
            applyFilter("")
        }
    }
}

//MARK: - Private

extension TableViewController {
    private func applyFilter(_ filter: String) {
        dataSource?.getBeers(withFilter: filter, completion: {[weak self] beers in
            if let beers = beers {
                self?.updateDataSource(withBeers: beers, animated: true)
            }
        })
    }
    
    private func configureSearchViewController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
    }
}
