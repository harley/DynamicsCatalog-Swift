//
//  APLGravityViewController.swift
//  DynamicsCatalog
//
//  Created by Harley Trung on 12/28/15.
//  Copyright © 2015 Apple Inc. All rights reserved.
//

import UIKit

class APLGravityViewController: UIViewController {
    var animator: UIDynamicAnimator!

    @IBOutlet weak var square1: UIImageView!

    override func viewDidAppear(animated: Bool) {
        let animator = UIDynamicAnimator(referenceView: view)
        let gravityBehavior = UIGravityBehavior(items: [square1])
        animator.addBehavior(gravityBehavior)
        self.animator = animator

    }
}