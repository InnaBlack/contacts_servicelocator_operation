//
//  ContactsRouterInterface.swift
//  contacts
//
//  Created by Nikolay Gladkovskiy on 06/02/2019.
//  Copyright © 2019 Nikolay Gladkovskiy. All rights reserved.
//

protocol ContactsRouterInput: class {
    func closeModule(animated: Bool)
    
    func openContactInfo(with identifier: String)
}
