//
//  ContactInfoAssembly.swift
//  contacts
//
//  Created by Nikolay Gladkovskiy on 06/02/2019.
//  Copyright © 2019 Nikolay Gladkovskiy. All rights reserved.
//

import UIKit

class ContactInfoAssembly {
    func viewContactInfoModule() -> ContactInfoViewController {
        let locator = LocatorService.current
        
        guard let vc = locator.contactsStoryboard.instantiateViewController(withIdentifier: "ContactInfo") as? ContactInfoViewController
            else {return ContactInfoViewController()}
        
        let interactor =
            ContactInfoInteractor.init(contactsService: locator.contactsService)
        
        let presenter = ContactInfoPresenter()
        let router = ContactInfoRouter()
        
        vc.output = presenter
        vc.input = presenter
        presenter.userInterface = vc
        
        interactor.output = presenter
        presenter.interactor = interactor
        
        router.viewController = vc
        presenter.router = router
        
        return vc
    }
}
