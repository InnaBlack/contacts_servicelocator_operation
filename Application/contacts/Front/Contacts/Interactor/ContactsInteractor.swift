//
//  ContactsInteractor.swift
//  contacts
//
//  Created by Nikolay Gladkovskiy on 06/02/2019.
//  Copyright © 2019 Nikolay Gladkovskiy. All rights reserved.
//

class ContactsInteractor
{
    weak var output: ContactsInteractorOutput!
    
    var contactsService: ContactsService
    
    var items = [ContactItem]()
    
    var filterString: String?
    
    init(contactsService: ContactsService)
    {
        self.contactsService = contactsService
        
        self.contactsService.delegate = self
    }
}


private extension ContactsInteractor
{
    typealias SortDescriptor<Value> = (Value, Value) -> Bool
    
    func loadTableData() -> TableData
    {
        items = contactItems()
        
        let section = TableSection.init(items: items, title: "")
        
        return TableData.init(sections: [section])
    }
    
    func contactItems() -> [ContactItem]
    {
        var contacts = contactsService.contacts
        
        if let filter = filterString, !filter.isEmpty
        {
            contacts = contacts.filter
                {
                   return $0.identifier.contains(filter)
                    || $0.phoneNumber.contains(filter)
                }
        }
        
        let alphabet: SortDescriptor<Contact> = SortDesc.sortDescriptor(key: {$0.name},
                                                                            ascending: true,
                                                                            SortDesc.simpleAccending())
        contacts.sort(by: alphabet)
        
        return makeItems(from: contacts)
    }

    func makeItems(from contacts: [Contact]) -> [ContactItem]
    {
        var items = [ContactItem]()
        for contact in contacts
        {
            let item = ContactItem.init(identifier: contact.identifier,
                                        title: contact.name,
                                        subtitle: contact.phoneNumber,
                                        detail: contact.temperament.rawValue)
            
            items.append(item)
        }
        return items
    }
}


extension ContactsInteractor: ContactsInteractorInput
{
    func loadItems()
    {
        let tableData = loadTableData()
        output.interactor(didLoad: tableData)
    }
}


extension ContactsInteractor: ContactsServiceOutput
{
    func didUpdateContacts()
    {
        loadItems()
    }

}
