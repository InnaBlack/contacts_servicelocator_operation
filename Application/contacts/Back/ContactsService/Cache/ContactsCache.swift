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
    func addOrUpdate(contacts: [Contact])
    {
        for contact in contacts
        {
            if let haveContact = self.contacts.first(where: {$0.identifier == contact.identifier})
            {
                haveContact.update(from: contact)
            }
            else
            {
                self.contacts.append(contact)
            }
            
            realm.beginWrite()
            if let haveRealmContact = realm.object(ofType: RealmContact.self, forPrimaryKey: contact.identifier)
            {
                haveRealmContact.update(from: contact)
            }
            else
            {
                realm.add(RealmContact.init(contact: contact))
            }
            try! realm.commitWrite()
        }
        
        
    }
}