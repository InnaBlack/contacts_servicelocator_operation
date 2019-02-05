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
    private var contactsList = [Contact]()
    
    var contacts: [Contact] {return contactsList}

    func addOrUpdate(contacts: [Contact])
    {
        print(contacts)
    }
}
