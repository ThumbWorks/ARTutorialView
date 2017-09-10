//
//  ViewController.swift
//  ARTutorialViewTestApp
//
//  Created by Roderic Campbell on 9/8/17.
//  Copyright © 2017 Roderic Campbell. All rights reserved.
//

import UIKit
import ARTutorialView
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let tutorialView = ARTutorialView()
        print(tutorialView)
        view.addSubview(tutorialView)
        tutorialView.translatesAutoresizingMaskIntoConstraints = false
        
        // pin the width
        tutorialView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tutorialView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

        tutorialView.topAnchor .constraint(equalTo: view.topAnchor).isActive = true
        tutorialView.bottomAnchor .constraint(equalTo: view.bottomAnchor).isActive = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

