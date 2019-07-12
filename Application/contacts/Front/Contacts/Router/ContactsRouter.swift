//
//  ContactsRouter.swift
//  contacts
//
//  Created by Nikolay Gladkovskiy on 06/02/2019.
//  Copyright © 2019 Nikolay Gladkovskiy. All rights reserved.
//

import UIKit


class ContactsRouter {
    weak var viewController: UIViewController!
}


extension ContactsRouter: ContactsRouterInput {
    func closeModule(animated: Bool) {
        viewController.navigationController?.popViewController(animated: animated)
    }
    
    func openContactInfo(with identifier: String) {
        let infoVC = ContactInfoAssembly().viewContactInfoModule()
        
        infoVC.input.configure(with: identifier)
        
        viewController.navigationController?.pushViewController(infoVC, animated: true)
    }
}
