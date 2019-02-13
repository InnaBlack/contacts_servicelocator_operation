//
//  ContactInfoViewController.swift
//  contacts
//
//  Created by Nikolay Gladkovskiy on 06/02/2019.
//  Copyright © 2019 Nikolay Gladkovskiy. All rights reserved.
//

import UIKit
import PureLayout


class ContactInfoViewController: UIViewController
{
    var output: ContactInfoViewOutput!
    var input: ContactInfoModuleInput!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var periodLabel: UILabel!
    @IBOutlet weak var temperamentLabel: UILabel!
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var biographyLabel: UILabel!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        configureController()
        output.viewDidReadyForEvents()
    }
}


private extension ContactInfoViewController
{
    func configureController()
    {
        title = "ContactInfo"
        callButton.addTarget(self, action: #selector(didPressOnCallButton), for: .touchUpInside)
    }
    
    func didPressOnBackButton()
    {
        output.viewDidPressOnBackButton()
    }
    
    @objc func didPressOnCallButton()
    {
        output.viewDidPressOnCallButton()
    }
}


extension ContactInfoViewController: ContactInfoViewInput
{
    func configure(with item: ContactInfoItem)
    {
        self.nameLabel.text = item.name
        self.periodLabel.text = item.educationPeriod
        self.temperamentLabel.text = item.temperament
        self.biographyLabel.text = item.biography
        self.callButton.setTitle(item.phoneNumber, for: .normal)
    }
}
