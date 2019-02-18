//
//  ContactsViewInterface.swift
//  contacts
//
//  Created by Nikolay Gladkovskiy on 06/02/2019.
//  Copyright © 2019 Nikolay Gladkovskiy. All rights reserved.
//


protocol ContactsViewInput: class
{
    func configure(with items: [ContactItem])
    
    func beginUpdates()
    
    func endUpdates(with items: [ContactItem])
    
    func deleteRows(at: [Int])
    
    func insertRows(at: [Int])
    
    func reloadRows(at: [Int])
    
    func showToast(_ text: String)
}


protocol ContactsViewOutput: class
{
    func viewDidReadyForEvents()
    
    func viewDidPress(on item: ContactItem)
    
    func viewDidStartRefresh()
    
    func viewDidChangeFilter(value: String?)
}
