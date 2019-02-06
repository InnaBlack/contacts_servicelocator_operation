//
//  ContactsService.swift
//  contacts
//
//  Created by Nikolay Gladkovskiy on 04/02/2019.
//  Copyright © 2019 Nikolay Gladkovskiy. All rights reserved.
//

import Foundation

class ContactsService
{
    private let cache : ContactsCache
    
    var contacts: [Contact]
    {
        return cache.contacts
    }

    init(databaseService: DataBaseService)
    {
        cache = ContactsCache.init(databaseService: databaseService)
    }
    
    func addOrUpdate(contacts: [Contact])
    {
        cache.addOrUpdate(contacts: contacts)
        
        // ContactServiceDidUpdateContacts
    }
}
