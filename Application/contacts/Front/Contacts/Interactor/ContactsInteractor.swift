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
    
    var items: Results<Contact>?
    
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
    func loadItems()
    {
//        if let filter = filterString, !filter.isEmpty{
//            items = contactsService.readContacts().filter
//                {
//                    return $0.identifier.contains(filter)
//                        || $0.phoneNumber.contains(filter)
//            }
//        }
//        else
//        {
           items = contactsService.readContacts()
//        }
        
        
        notificationToken = items?.observe(
            { [weak self] (changes) in
                
                guard let initialItems = self?.items else {return}
                
                switch changes
                {
                case .initial:
                    self?.output.interactorDidLoad(items: initialItems)
                    
                case .update(_, let deletions, let insertions, let modifications):

                    self?.output.interactorNeedsBeginUpdates()
                    
                    self?.output.interactorNeedsDelete(rows: deletions)
                    
                    self?.output.interactorNeedsInsert(rows: insertions)
                    
                    self?.output.interactorNeedsReload(rows: modifications)
                    
                    self?.output.interactorNeedsEndUpdates()
                    
                case .error(let err):
                    
                    fatalError("\(err)")
                }
        })
    }
}


extension ContactsInteractor: ContactsServiceOutput
{
    func didUpdateContacts()
    {
        //
    }
    

}
