//
//  ContactInfoRouter.swift
//  contacts
//
//  Created by Nikolay Gladkovskiy on 06/02/2019.
//  Copyright © 2019 Nikolay Gladkovskiy. All rights reserved.
//

import UIKit


class ContactInfoRouter
{
    weak var viewController: UIViewController!
}


extension ContactInfoRouter: ContactInfoRouterInput
{    
    func goTo(externalLink: URL)
    {
        if UIApplication.shared.canOpenURL(externalLink)
        {
            UIApplication.shared.open(externalLink)
        }
    }
}
