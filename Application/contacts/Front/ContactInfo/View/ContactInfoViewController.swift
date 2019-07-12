//
//  ContactInfoViewController.swift
//  contacts
//
//  Created by Nikolay Gladkovskiy on 06/02/2019.
//  Copyright © 2019 Nikolay Gladkovskiy. All rights reserved.
//

import UIKit


class ContactInfoViewController: UIViewController {
    var output: ContactInfoViewOutput!
    var input: ContactInfoModuleInput!
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var periodLabel: UILabel!
    @IBOutlet weak var temperamentLabel: UILabel!
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var biographyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureController()
        output.viewDidReadyForEvents()
    }
}


private extension ContactInfoViewController {
    func configureController() {
        title = "Details"
        navigationItem.largeTitleDisplayMode = .never
        
        callButton.addTarget(self, action: #selector(didPressOnCallButton), for: .touchUpInside)
    }
    
    @objc func didPressOnCallButton() {
        output.viewDidPressOnCallButton()
    }
}


extension ContactInfoViewController: ContactInfoViewInput {
    func configure(with item: ContactInfoItem) {
        nameLabel.text = item.name
        periodLabel.text = item.educationPeriod
        temperamentLabel.text = item.temperament
        biographyLabel.text = item.biography
        
        callButton.setTitle(item.phoneNumber, for: .normal)
        callButton.setImage(UIImage.init(named: "phone"), for: .normal)
        
        stackView.layoutSubviews()
    }
}
