//
//  ContactInfoInteractorInterface.swift
//  contacts
//
//  Created by Nikolay Gladkovskiy on 06/02/2019.
//  Copyright © 2019 Nikolay Gladkovskiy. All rights reserved.
//

import RealmSwift


protocol ContactInfoInteractorInput: class {
    func configure(with contactId: String)
    
    func urlForCall() -> URL?
}


protocol ContactInfoInteractorOutput: class {
    func interactorDidLoad(item: ContactInfoItem)
}
