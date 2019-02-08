//
//  ContactsViewInterface.swift
//  contacts
//
//  Created by Nikolay Gladkovskiy on 06/02/2019.
//  Copyright © 2019 Nikolay Gladkovskiy. All rights reserved.
//

protocol ContactsViewInput: class
{
    func configure(with tableData: TableData)
    
    func update(with tableData: TableData)
}


protocol ContactsViewOutput: class
{
    func viewDidReadyForEvents()
    
    func viewDidPressOnBackButton()
    
    func viewDidPress(on item: ContactItem)
    
    func viewDidStartRefresh()
}
