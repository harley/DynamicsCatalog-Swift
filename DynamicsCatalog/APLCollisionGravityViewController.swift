//
//  APLCollisionGravityViewController.swift
//  DynamicsCatalog
//
//  Created by Harley Trung on 12/28/15.
//  Copyright © 2015 Apple Inc. All rights reserved.
//

import UIKit


class APLCollisionGravityViewController: UIViewController {
    var animator: UIDynamicAnimator!

    @IBOutlet weak var square1: UIImageView!


    override func viewDidLoad() {
        super.viewDidLoad()

        // Make the square a template image so its color can be changed
        // by adjusting the tintColor of the UIImageView displaying it.
        square1.image = square1.image?.imageWithRenderingMode(.AlwaysTemplate)
        square1.tintColor = UIColor.darkGrayColor()

    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let animator = UIDynamicAnimator(referenceView: view)

        let gravityBehavior = UIGravityBehavior(items: [square1])
        animator.addBehavior(gravityBehavior)

        let collisionBehavior = UICollisionBehavior(items: [square1])
        // create collision boundaries from the bounds of the dynamic animator's reference view, which is self.view
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        collisionBehavior.collisionDelegate = self
        animator.addBehavior(collisionBehavior)

        self.animator = animator

    }
}

extension APLCollisionGravityViewController: UICollisionBehaviorDelegate {
    //  This method is called when square1 begins contacting a collision boundary.
    //  In this demo, the only collision boundary is the bounds of the reference
    //  view (self.view).

    func collisionBehavior(behavior: UICollisionBehavior, beganContactForItem item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, atPoint p: CGPoint) {
        let itemView = item as! UIView
        itemView.tintColor = UIColor.lightGrayColor()
    }

    func collisionBehavior(behavior: UICollisionBehavior, endedContactForItem item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?) {
        let itemView = item as! UIView
        itemView.tintColor = UIColor.darkGrayColor()
    }
}
