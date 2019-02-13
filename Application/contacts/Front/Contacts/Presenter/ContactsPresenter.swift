//
//  ContactsPresenter.swift
//  contacts
//
//  Created by Nikolay Gladkovskiy on 06/02/2019.
//  Copyright © 2019 Nikolay Gladkovskiy. All rights reserved.
//

import RealmSwift


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
    
    func viewDidPress(on item: CellItem)
    {
       
    }
    
    func viewDidStartRefresh()
    {
        interactor.loadItems()
    }
}


extension ContactsPresenter: ContactsInteractorOutput
{
    func interactorDidLoad(items: Results<Contact>)
    {
        userInterface?.configure(with: items)
    }
    
    func interactorNeedsBeginUpdates()
    {
        userInterface?.beginUpdates()
    }
    
    func interactorNeedsEndUpdates()
    {
        userInterface?.endUpdates()
    }
    
    func interactorNeedsDelete(rows: [Int])
    {
        userInterface?.deleteRows(at: rows)
    }
    
    func interactorNeedsInsert(rows: [Int])
    {
        userInterface?.insertRows(at: rows)
    }
    
    func interactorNeedsReload(rows: [Int])
    {
        userInterface?.reloadRows(at: rows)
    }
    


}
