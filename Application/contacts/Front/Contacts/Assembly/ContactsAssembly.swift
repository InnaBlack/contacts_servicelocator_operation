//
//  ContactsAssembly.swift
//  contacts
//
//  Created by Nikolay Gladkovskiy on 06/02/2019.
//  Copyright © 2019 Nikolay Gladkovskiy. All rights reserved.
//

class ContactsAssembly
{
    func viewContactsModule() -> ContactsViewController
    {
        let locator = LocatorService.current
        
        let interactor =
            ContactsInteractor.init(contactsService: locator.contactsService)
        
        let vc = ContactsViewController()
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
