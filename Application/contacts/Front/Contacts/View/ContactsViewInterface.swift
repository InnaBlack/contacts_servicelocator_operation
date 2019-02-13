//
//  ContactsViewInterface.swift
//  contacts
//
//  Created by Nikolay Gladkovskiy on 06/02/2019.
//  Copyright © 2019 Nikolay Gladkovskiy. All rights reserved.
//


protocol ContactsViewInput: class
{
    func configure(with tableData: [CellItem])
    
    func beginUpdates()
    
    func endUpdates(with tableData: [CellItem])
    
    func deleteRows(at: [Int])
    
    func insertRows(at: [Int])
    
    func reloadRows(at: [Int])
    
    func setSearchBar(hidden: Bool)
}


protocol ContactsViewOutput: class
{
    func viewDidReadyForEvents()
    
    func viewDidPressOnBackButton()
    
    func viewDidPress(on item: CellItem)
    
    func viewDidStartRefresh()
    
    func viewDidChangeFilter(value: String)
}
