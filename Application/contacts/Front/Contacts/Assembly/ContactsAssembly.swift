//
//  ContactsAssembly.swift
//  contacts
//
//  Created by Nikolay Gladkovskiy on 06/02/2019.
//  Copyright © 2019 Nikolay Gladkovskiy. All rights reserved.
//

import UIKit

class ContactsAssembly
{
    func viewContactsModule() -> ContactsViewController
    {
        let locator = LocatorService.current
        
        guard let vc = locator.contactsStoryboard.instantiateViewController(withIdentifier: "ContactsTVC") as? ContactsViewController
            else {return ContactsViewController()}
        
        let interactor =
            ContactsInteractor.init(contactsService: locator.contactsService)
        
        let presenter = ContactsPresenter()
        let router = ContactsRouter()
        
        vc.output = presenter
        presenter.userInterface = vc
        
        interactor.output = presenter
        presenter.interactor = interactor
        
        router.viewController = vc
        presenter.router = router
        
        return vc
    }
}
