//
//  ContactsService.swift
//  contacts
//
//  Created by Nikolay Gladkovskiy on 05/02/2019.
//  Copyright © 2019 Nikolay Gladkovskiy. All rights reserved.
//

import Foundation
import RealmSwift

protocol ContactsServiceInput
{
    func readContacts() -> Results<Contact>
    func writeContacts(from data: Data)
}


protocol ContactsServiceOutput
{
    func didUpdateContacts()
}

class ContactsService
{
    private var readRealm: Realm!
    
    var contacts: Results<Contact>!
    
    let databaseService: DataBaseService
    
    init(databaseService: DataBaseService)
    {
        readRealm = databaseService.readRealm
        
        self.databaseService = databaseService
        
        contacts = readContacts()
    }
}

extension ContactsService: ContactsServiceInput
{
    func readContacts() -> Results<Contact>
    {
        return readRealm.objects(Contact.self).sorted(byKeyPath: Contact.CodingKeys.name.rawValue, ascending: true)
    }
    
    func writeContacts(from data: Data)
    {
        DispatchQueue.global().async {
            autoreleasepool{
                [weak self] in
                    
                    guard let self = self else {return}
                    
                    let writeRealm = self.databaseService.newRealm
                    try! writeRealm.write
                    {
                        do
                        {
                            let decoder = JSONDecoder()
                            decoder.dateDecodingStrategy = .iso8601
                            let contacts = try decoder.decode([Contact].self, from: data)
                            writeRealm.add(contacts)
                        }
                        catch
                        {
                            print(error)
                        }
                    }
                }
            }
    }
}

extension ContactsService: ContactsServiceOutput
{
    func didUpdateContacts()
    {
        //
    }
}
