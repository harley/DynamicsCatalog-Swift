//
//  SnapViewController.swift
//  DynamicsCatalog
//
//  Created by Harley Trung on 12/28/15.
//  Copyright © 2015 Apple Inc. All rights reserved.
//

import UIKit

class SnapViewController: UIViewController {
    var animator: UIDynamicAnimator!
    var snapBehavior: UISnapBehavior?

    @IBOutlet weak var square1: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let animator = UIDynamicAnimator(referenceView: view)
        self.animator = animator
    }

    @IBAction func handleSnapGesture(gesture: UITapGestureRecognizer) {
        let point = gesture.locationInView(view)

        // remove the previous behavior
        if let snapBehavior = self.snapBehavior {
            animator.removeBehavior(snapBehavior)
        }

        let snapBehavior = UISnapBehavior(item: square1, snapToPoint: point)
        animator.addBehavior(snapBehavior)
        self.snapBehavior = snapBehavior
    }
}
