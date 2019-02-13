//
//  ContactsViewController.swift
//  contacts
//
//  Created by Nikolay Gladkovskiy on 06/02/2019.
//  Copyright © 2019 Nikolay Gladkovskiy. All rights reserved.
//

import UIKit
import PureLayout

let cellReuseIdentifier = "DetailedCell"

class ContactsViewController: UITableViewController
{
    var output: ContactsViewOutput!

    private var tableData: [CellItem]?
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        configureController()
        configureRefreshControl()
        configureTableViewOffset()
        configureSearchBar()
        output.viewDidReadyForEvents()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
       configureTableViewOffset()
    }
}


private extension ContactsViewController
{
    func configureController()
    {
        title = "Contacts"
    }
    
    func configureRefreshControl()
    {
        let refreshControl = UIRefreshControl.init()
        tableView.addSubview(refreshControl)
        refreshControl.tintColor = .orange
        refreshControl.attributedTitle = NSAttributedString.init(string: "Let's cook")
        refreshControl.addTarget(self, action: #selector(refreshContent), for: .valueChanged)
        self.refreshControl = refreshControl
    }
    
    func configureTableView()
    {
        tableView.tableFooterView = UIView.init(frame: CGRect.zero)
    }
    
    @objc func refreshContent()
    {
        output.viewDidStartRefresh()
    }
    
    func configureTableViewOffset()
    {
            tableView.contentOffset = CGPoint.init(x: 0, y: self.searchBar.frame.height)
    }
    
    func didPressOnBackButton()
    {
        output.viewDidPressOnBackButton()
    }
    
    func configureSearchBar()
    {
        searchBar.delegate = self
    }
}

extension ContactsViewController: UISearchBarDelegate
{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        output.viewDidChangeFilter(value: searchText)
    }
}


extension ContactsViewController
{
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    override func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int
    {
        guard let items = tableData else {return 1}
        return items.count
    }
    
    override func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let detailedCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        
        return detailedCell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        guard let items = tableData else {return}
        
        guard let detailedCell = cell as? ContactsTVCell else {return}
        
        let item = items[indexPath.row]
        
        detailedCell.titleLabel.text = item.title
        
        detailedCell.subtitleLabel.text = item.subtitle
        
        detailedCell.detailLabel.text = item.detail
        
    }
}


extension ContactsViewController
{
    override func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 60.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        guard let items = tableData else {return}
        let selectedItem = items[indexPath.row]
        
        output.viewDidPress(on: selectedItem)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


extension ContactsViewController: ContactsViewInput
{
    func beginUpdates()
    {
        tableView.beginUpdates()
    }
    
    func endUpdates(with tableData: [CellItem])
    {
        self.tableData = tableData
        tableView.endUpdates()
    }
    
    func deleteRows(at indexes: [Int])
    {
        tableView.deleteRows(at: indexes.map { IndexPath(row: $0, section: 0) },
                                  with: .automatic)
    }
    
    func insertRows(at indexes: [Int])
    {
        tableView.insertRows(at: indexes.map { IndexPath(row: $0, section: 0) },
                             with: .automatic)
    }
    
    func reloadRows(at indexes: [Int])
    {
        tableView.reloadRows(at: indexes.map { IndexPath(row: $0, section: 0) },
                             with: .automatic)
    }
    
    func configure(with tableData: [CellItem])
    {
        self.tableData = tableData
        
        refreshControl?.endRefreshing()
        
        tableView.reloadData()
    }
    
    func setSearchBar(hidden: Bool)
    {
        searchBar.isHidden = hidden
    }
}
