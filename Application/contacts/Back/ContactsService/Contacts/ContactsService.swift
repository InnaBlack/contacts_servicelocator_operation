//
//  ContactsService.swift
//  contacts
//
//  Created by Nikolay Gladkovskiy on 04/02/2019.
//  Copyright © 2019 Nikolay Gladkovskiy. All rights reserved.
//

import Foundation


protocol ContactsServiceInput
{
    func addOrUpdate(contacts: [Contact])
}


protocol ContactsServiceOutput
{
    func didUpdateContacts()
}


class ContactsService
{
    var delegate: ContactsServiceOutput?
    
    private let cache: ContactsCache
    
    var contacts: [Contact]
    {
        return cache.contacts
    }

    init(databaseService: DataBaseService)
    {
        cache = ContactsCache.init(databaseService: databaseService)
    }
}


extension ContactsService: ContactsServiceInput
{
    func addOrUpdate(contacts: [Contact])
    {
        cache.addOrUpdate(contacts: contacts)
        
        delegate?.didUpdateContacts()
    }
}
