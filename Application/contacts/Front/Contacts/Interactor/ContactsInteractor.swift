//
//  ContactsInteractor.swift
//  contacts
//
//  Created by Nikolay Gladkovskiy on 06/02/2019.
//  Copyright © 2019 Nikolay Gladkovskiy. All rights reserved.
//

import RealmSwift

extension Contact: CellItem
{
    var title: String {return name}
    
    var subtitle: String {return phoneNumber}
    
    var detail: String {return temperament}
}

class ContactsInteractor
{
    weak var output: ContactsInteractorOutput!
    
    var contactsService: ContactsService
    
    var filterString: String?
    
    var notificationToken: NotificationToken?

    init(contactsService: ContactsService)
    {
        self.contactsService = contactsService
    }
    
    deinit
    {
        notificationToken?.invalidate()
    }
}


private extension ContactsInteractor
{

}


extension ContactsInteractor: ContactsInteractorInput
{
    func loadItems(with filter: String?)
    {
        let resultContacts = contactsService.readContacts(with: filter)
        
        notificationToken = resultContacts.observe(
            { [weak self] (changes) in
                
                let items = Array.init(resultContacts)
                switch changes
                {
                case .initial:

                    self?.output.interactorDidLoad(items: items)
                    
                case .update(_, let deletions, let insertions, let modifications):

                    self?.output.interactorNeedsBeginUpdates()
                    
                    self?.output.interactorNeedsDelete(rows: deletions)
                    
                    self?.output.interactorNeedsInsert(rows: insertions)
                    
                    self?.output.interactorNeedsReload(rows: modifications)
                    
                    self?.output.interactorNeedsEndUpdate(items: items)
                    
                case .error(let err):
                    
                    fatalError("\(err)")
                }
        })
    }
}
