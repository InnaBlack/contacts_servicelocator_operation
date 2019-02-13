//
//  ContactInfoRouterInterface.swift
//  contacts
//
//  Created by Nikolay Gladkovskiy on 06/02/2019.
//  Copyright © 2019 Nikolay Gladkovskiy. All rights reserved.
//

import Foundation


protocol ContactInfoRouterInput: class
{
    func closeModule(animated: Bool)
    
    func goTo(externalLink: URL)
}
