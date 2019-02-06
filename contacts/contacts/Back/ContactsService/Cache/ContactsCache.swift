//
//  ContactsCache.swift
//  contacts
//
//  Created by Nikolay Gladkovskiy on 05/02/2019.
//  Copyright © 2019 Nikolay Gladkovskiy. All rights reserved.
//

import Foundation
import RealmSwift

class ContactsCache
{
    var realm: Realm
    var contacts = [Contact]()
    
    init(databaseService: DataBaseService)
    {
        realm = databaseService.contactRealm
        contacts = loadContacts()
    }
}

private extension ContactsCache
{
    func loadContacts() -> [Contact]
    {
        var result = [Contact]()
        
        let realmContacts = realm.objects(RealmContact.self)
        
        for realmContact in realmContacts
        {
            result.append(realmContact.contact())
        }
        
        return result
    }
}

extension ContactsCache
{
    func save(contacts: [Contact])
    {
        
    }
}
