//
//  ContactsViewInterface.swift
//  contacts
//
//  Created by Nikolay Gladkovskiy on 06/02/2019.
//  Copyright © 2019 Nikolay Gladkovskiy. All rights reserved.
//


protocol ContactsViewInput: class
{
    func configure(with items: [CellItem])
    
    func beginUpdates()
    
    func endUpdates(with items: [CellItem])
    
    func deleteRows(at: [Int])
    
    func insertRows(at: [Int])
    
    func reloadRows(at: [Int])
}


protocol ContactsViewOutput: class
{
    func viewDidReadyForEvents()
    
    func viewDidPressOnBackButton()
    
    func viewDidPress(on item: CellItem)
    
    func viewDidStartRefresh()
    
    func viewDidChangeFilter(value: String?)
}
