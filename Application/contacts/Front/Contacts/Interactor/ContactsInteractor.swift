//
//  ContactsInteractor.swift
//  contacts
//
//  Created by Nikolay Gladkovskiy on 06/02/2019.
//  Copyright © 2019 Nikolay Gladkovskiy. All rights reserved.
//

import RealmSwift


extension Contact: ContactItem
{
    var title: String {return name}
    
    var subtitle: String {return phoneNumber}
    
    var detail: String {return temperament}
}


class ContactsInteractor
{
    weak var output: ContactsInteractorOutput!
    
    var contactsService: ContactsServiceInput
    
    var loadService: LoadServiceInput
    
    var filterString: String?
    
    var notificationToken: NotificationToken?

    init(contactsService: ContactsServiceInput, loadService: LoadServiceInput)
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
        loadService.syncIfNeed
            {[weak self] (error) in

                guard let resultContacts = self?.contactsService.readContacts(with: filter) else {return}
                
                self?.notificationToken = resultContacts.observe(
                    { [weak self] (changes) in
                        
                        let items = Array.init(resultContacts)
                        
                        self?.output.interactorDidLoad(items: items)
                })
        }
    }
    
    func reloadItems()
    {
        loadService.syncIfNeed
            {[weak self] (error) in
           
                guard let strongError = error else {return}
                let loadError = strongError as NSError
                
                self?.output.interactorNeedsShowAlert(with: loadError.localizedDescription)
            }
    }
}
