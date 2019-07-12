//
//  ContactInfoViewInterface.swift
//  contacts
//
//  Created by Nikolay Gladkovskiy on 06/02/2019.
//  Copyright © 2019 Nikolay Gladkovskiy. All rights reserved.
//

protocol ContactInfoViewInput: class {
    func configure(with item: ContactInfoItem)
}


protocol ContactInfoViewOutput: class {
    func viewDidReadyForEvents()
    
    func viewDidPressOnCallButton()
}
