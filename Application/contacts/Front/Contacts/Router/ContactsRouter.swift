//
//  ContactsRouter.swift
//  contacts
//
//  Created by Nikolay Gladkovskiy on 06/02/2019.
//  Copyright © 2019 Nikolay Gladkovskiy. All rights reserved.
//

import UIKit


class ContactsRouter
{
    weak var viewController: UIViewController!
}


extension ContactsRouter: ContactsRouterInput
{
    func closeModule(animated: Bool)
    {
        viewController.navigationController?.popViewController(animated: animated)
    }
}
