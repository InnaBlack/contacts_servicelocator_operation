//
//  ContactsInteractorInterface.swift
//  contacts
//
//  Created by Nikolay Gladkovskiy on 06/02/2019.
//  Copyright © 2019 Nikolay Gladkovskiy. All rights reserved.
//

protocol ContactsInteractorInput: class
{
    func loadItems()
}


protocol ContactsInteractorOutput: class
{
    func interactor(didLoad tableData: TableData)
}
