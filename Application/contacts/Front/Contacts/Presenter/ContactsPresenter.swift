//
//  ContactsPresenter.swift
//  contacts
//
//  Created by Nikolay Gladkovskiy on 06/02/2019.
//  Copyright © 2019 Nikolay Gladkovskiy. All rights reserved.
//


class ContactsPresenter {
    weak var userInterface: ContactsViewInput?
    var interactor: ContactsInteractorInput!
    var router: ContactsRouterInput!
    
    private var filterString: String?
}


extension ContactsPresenter: ContactsViewOutput {
    func viewDidReadyForEvents() {
        interactor.loadItems()
    }
    
    func viewDidPress(on item: ContactItem) {
        router.openContactInfo(with: item.identifier)
    }
    
    func viewDidStartRefresh() {
        interactor.reloadItems()
    }
    
    func viewDidChangeFilter(value: String?) {
        interactor.update(filter: value)
        interactor.loadItems()
    }
}


extension ContactsPresenter: ContactsInteractorOutput {
    func interactorDidLoad(items: [ContactItem]) {
        userInterface?.configure(with: items)
    }
    
    func interactorNeedsBeginUpdates() {
        userInterface?.beginUpdates()
    }
    
    func interactorNeedsEndUpdate(items: [ContactItem]) {
        userInterface?.endUpdates(with: items)
    }
    
    func interactorNeedsDelete(rows: [Int]) {
        userInterface?.deleteRows(at: rows)
    }
    
    func interactorNeedsInsert(rows: [Int]) {
        userInterface?.insertRows(at: rows)
    }
    
    func interactorNeedsReload(rows: [Int]) {
        userInterface?.reloadRows(at: rows)
    }
    
    func interactorNeedsShowAlert(with text: String) {
        userInterface?.showToast(text)
    }
}
