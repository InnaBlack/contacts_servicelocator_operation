//
//  RootWindowService.swift
//  contacts
//
//  Created by Nikolay Gladkovskiy on 08/02/2019.
//  Copyright © 2019 Nikolay Gladkovskiy. All rights reserved.
//

import Foundation
import UIKit


protocol RootWindowInput
{
    func show(viewController: UIViewController)
    
    func push(viewController: UIViewController)
}


protocol RootWindowOutput
{
    
}


class RootWindowService
{
    var window = UIWindow.init(frame: UIScreen.main.bounds)
    
    var rootNavigationController: UINavigationController? = nil
}


extension RootWindowService: RootWindowInput
{
    func push(viewController: UIViewController)
    {
        if let rootNC = rootNavigationController
        {
            rootNC.pushViewController(viewController, animated: true)
            show(viewController: rootNC)
        }
        else
        {
            let rootNC = UINavigationController.init(rootViewController: viewController)
            rootNavigationController = rootNC
            show(viewController: rootNC)
        }
    }
    
    func show(viewController: UIViewController)
    {
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
}

private extension RootWindowService
{
    
}
