//
//  ContactsInteractorInterface.swift
//  contacts
//
//  Created by Nikolay Gladkovskiy on 06/02/2019.
//  Copyright © 2019 Nikolay Gladkovskiy. All rights reserved.
//

import RealmSwift


protocol ContactsInteractorInput: class
{
    func loadItems()
}


protocol ContactsInteractorOutput: class
{
    func interactorDidLoad(items: Results<Contact>)
    
    func interactorNeedsBeginUpdates()
    
    func interactorNeedsEndUpdates()
    
    func interactorNeedsDelete(rows :[Int])
    
    func interactorNeedsInsert(rows :[Int])
    
    func interactorNeedsReload(rows :[Int])
}
