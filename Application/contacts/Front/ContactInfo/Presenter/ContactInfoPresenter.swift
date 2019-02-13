//
//  ContactInfoPresenter.swift
//  contacts
//
//  Created by Nikolay Gladkovskiy on 06/02/2019.
//  Copyright © 2019 Nikolay Gladkovskiy. All rights reserved.
//

import RealmSwift


protocol ContactInfoModuleInput
{
    func configure(with identifier: String)
}

class ContactInfoPresenter
{
    weak var userInterface: ContactInfoViewInput?
    var interactor: ContactInfoInteractorInput!
    var router: ContactInfoRouterInput!
    
    private var identifier: String?
}


extension ContactInfoPresenter: ContactInfoModuleInput
{
    func configure(with identifier: String)
    {
        self.identifier = identifier
    }
}


extension ContactInfoPresenter: ContactInfoViewOutput
{
    func viewDidReadyForEvents()
    {
        if let contactId = identifier
        {
            interactor.configure(with: contactId)
        }
    }
    
    func viewDidPressOnBackButton()
    {
        router.closeModule(animated: true)
    }
    
    func viewDidPressOnCallButton()
    {
        if let externalLink = interactor.urlForCall()
        {
            router.goTo(externalLink: externalLink)
        }
    }
}


extension ContactInfoPresenter: ContactInfoInteractorOutput
{
    func interactorDidLoad(item: ContactInfoItem)
    {
        userInterface?.configure(with: item)
    }

}
