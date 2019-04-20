//
//  ContactsInteractorInterface.swift
//  contacts
//
//  Created by Nikolay Gladkovskiy on 06/02/2019.
//  Copyright © 2019 Nikolay Gladkovskiy. All rights reserved.
//

protocol ContactsInteractorInput: class
{
    func update(filter: String?)
    
    func loadItems()
    
    func reloadItems()
}


protocol ContactsInteractorOutput: class
{
    func interactorDidLoad(items: [ContactItem])
    
    func interactorNeedsBeginUpdates()
    
    func interactorNeedsEndUpdate(items: [ContactItem])
    
    func interactorNeedsDelete(rows :[Int])
    
    func interactorNeedsInsert(rows :[Int])
    
    func interactorNeedsReload(rows :[Int])
    
    func interactorNeedsShowAlert(with text: String)
}
