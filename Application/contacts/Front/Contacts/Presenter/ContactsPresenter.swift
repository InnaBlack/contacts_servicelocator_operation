//
//  ContactsPresenter.swift
//  contacts
//
//  Created by Nikolay Gladkovskiy on 06/02/2019.
//  Copyright © 2019 Nikolay Gladkovskiy. All rights reserved.
//

class ContactsPresenter
{
    weak var userInterface: ContactsViewInput?
    var interactor: ContactsInteractorInput!
    var router: ContactsRouterInput!
}


extension ContactsPresenter: ContactsViewOutput
{
    func viewDidReadyForEvents()
    {
        interactor.loadItems()
    }
    
    func viewDidPressOnBackButton()
    {
        router.closeModule(animated: true)
    }
    
    func viewDidPress(on item: ContactItem)
    {
       
    }
    
    func viewDidStartRefresh()
    {
        interactor.loadItems()
    }
}


extension ContactsPresenter: ContactsInteractorOutput
{
    func interactor(didLoad tableData: TableData)
    {
        self.userInterface?.configure(with: tableData)
    }
}
