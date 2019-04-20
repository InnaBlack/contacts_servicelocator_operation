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
    func loadItems()
    {
        loadService.syncIfNeed
            {[weak self] (error) in

                guard var resultContacts = self?.contactsService.readContacts(with: self?.filterString) else {return}
                
                self?.notificationToken = resultContacts.observe(
                    { [weak self] (changes) in
                        
                        guard let self = self else {return}
                        
                        switch changes
                        {
                        case .initial:
                            let items = Array.init(resultContacts)
                            self.output.interactorDidLoad(items: items)
                            
                        case .update(_, _, _, _):
                            resultContacts = self.contactsService.readContacts(with: self.filterString)
                            let items = Array.init(resultContacts)
                            self.output.interactorDidLoad(items: items)
                            
                        case .error(let error):
                            let loadError = error as NSError
                            self.output.interactorNeedsShowAlert(with: loadError.localizedDescription)
                        }
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
    
    func update(filter: String?)
    {
        filterString = filter
    }
}
