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
    
    private var filterString: String?
}


extension ContactsPresenter: ContactsViewOutput
{
    func viewDidReadyForEvents()
    {
        interactor.loadItems(with: filterString)
    }
    
    func viewDidPress(on item: CellItem)
    {
       router.openContactInfo(with: item.identifier)
    }
    
    func viewDidStartRefresh()
    {
        interactor.reloadItems()
    }
    
    func viewDidChangeFilter(value: String?)
    {
        filterString = value
        interactor.loadItems(with: filterString)
    }
}


extension ContactsPresenter: ContactsInteractorOutput
{
    func interactorDidLoad(items: [CellItem])
    {
        userInterface?.configure(with: items)
    }
    
    func interactorNeedsBeginUpdates()
    {
        userInterface?.beginUpdates()
    }
    
    func interactorNeedsEndUpdate(items: [CellItem])
    {
        userInterface?.endUpdates(with: items)
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
    
    func interactorNeedsShowAlert(with text: String)
    {
        userInterface?.showToast(text)
    }

}
