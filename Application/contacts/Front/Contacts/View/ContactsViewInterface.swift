//
//  ContactsViewInterface.swift
//  contacts
//
//  Created by Nikolay Gladkovskiy on 06/02/2019.
//  Copyright © 2019 Nikolay Gladkovskiy. All rights reserved.
//

import RealmSwift


protocol ContactsViewInput: class
{
    func configure(with tableData: Results<Contact>)
    
    func beginUpdates()
    
    func endUpdates()
    
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
}
