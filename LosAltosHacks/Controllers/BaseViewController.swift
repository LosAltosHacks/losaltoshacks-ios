//
//  BaseViewController.swift
//  LosAltosHacks
//
//  Created by Dan Appel on 12/28/15.
//  Copyright © 2015 Dan Appel. All rights reserved.
//

import UIKit

protocol SnapKitView {
    func setupConstraints()
}

class BaseViewController: UIViewController, SnapKitView {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupConstraints()
    }
    
    func setupConstraints() { }
}

class BaseView: UIView, SnapKitView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupConstraints()
    }
    
    func setupConstraints() { }
}