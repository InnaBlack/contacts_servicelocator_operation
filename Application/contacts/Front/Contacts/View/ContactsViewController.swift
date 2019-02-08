//
//  ContactsViewController.swift
//  contacts
//
//  Created by Nikolay Gladkovskiy on 06/02/2019.
//  Copyright © 2019 Nikolay Gladkovskiy. All rights reserved.
//

import UIKit
import PureLayout

class ContactsViewController: UIViewController
{
    var output: ContactsViewOutput!
    
    private var tableView: UITableView!
    private var tableData: TableData!
    private let refreshControl = UIRefreshControl.init()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        configureController()
        configureTableView()
        
        output.viewDidReadyForEvents()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
       configureTableViewInsets()
    }
}


private extension ContactsViewController
{
    func configureController()
    {
        title = ""
    }
    
    func configureTableView()
    {
        tableView = UITableView.init(frame: view.frame,
                                     style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.autoPinEdgesToSuperviewEdges()
        
        tableView.allowsSelection = true
        tableView.estimatedRowHeight = 44.0
        tableView.tableFooterView = UIView.init(frame: CGRect.zero)
        
        if #available(iOS 11.0, *)
        {
            tableView.contentInsetAdjustmentBehavior = .never
        }
        
        tableView.addSubview(refreshControl)
        refreshControl.tintColor = .orange
        refreshControl.attributedTitle = NSAttributedString.init(string: "Let's cook")
        refreshControl.addTarget(self, action: #selector(refreshContent), for: .valueChanged)
    }
    
    @objc func refreshContent()
    {
        output.viewDidStartRefresh()
    }
    
    func configureTableViewInsets()
    {
        if let navigationController = self.navigationController
        {
            if navigationController.navigationBar.isTranslucent
            {
                let navigationControllerHeight = navigationController.navigationBar.bounds.size.height
                let statusBarOrientation = UIApplication.shared.statusBarOrientation
                let statusBarIsPortret = (statusBarOrientation == .portrait || statusBarOrientation == .portraitUpsideDown)
                let statusBarHeight = statusBarIsPortret ? UIApplication.shared.statusBarFrame.height : UIApplication.shared.statusBarFrame.width
                
                tableView.contentInset = UIEdgeInsets.init(top: navigationControllerHeight + statusBarHeight, left: 0, bottom: 0, right: 0)
            }
        }
    }
    
    func didPressOnBackButton()
    {
        output.viewDidPressOnBackButton()
    }
}


extension ContactsViewController: UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return tableData?.sections.count ?? 0
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int
    {
        return tableData.sections[section].items.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let settingsCell = UITableViewCell.init(style: .value1,
                                                reuseIdentifier: nil)
        settingsCell.contentView.backgroundColor = settingsCell.backgroundColor
        
        if let item = tableData.item(for: indexPath) as? ContactItem
        {
            settingsCell.textLabel?.text = item.title
            
            settingsCell.detailTextLabel?.text = item.subtitle
        }
        
        return settingsCell
    }
}


extension ContactsViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        guard let selectedItem = tableData.item(for: indexPath) as? ContactItem else {return}
        output.viewDidPress(on: selectedItem)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


extension ContactsViewController: ContactsViewInput
{
    func configure(with tableData: TableData)
    {
        self.tableData = tableData
        
        refreshControl.endRefreshing()
        
        tableView.reloadData()
    }
    
    func update(with tableData: TableData)
    {
        self.tableData = tableData
        
        tableView.reloadData()
    }
}
