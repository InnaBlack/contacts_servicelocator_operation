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
    
    var loadService: LoadService
    
    var filterString: String?
    
    var notificationToken: NotificationToken?

    init(contactsService: ContactsService, loadService: LoadService)
    {
        self.contactsService = contactsService
        
        self.loadService = loadService
    }
    
    deinit
    {
        notificationToken?.invalidate()
    }
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
    
    func reloadItems()
    {
        loadService.sync(with:
            {[weak self] (error) in
           
                guard let strongError = error else {return}
                let loadError = strongError as NSError
                
                
                self?.output.interactorNeedsShowAlert(with: loadError.localizedDescription)
            })
    }
}
