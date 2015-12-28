//
//  InstantaneousPushViewController.swift
//  DynamicsCatalog
//
//  Created by Harley Trung on 12/28/15.
//  Copyright © 2015 Apple Inc. All rights reserved.
//

import UIKit

class InstantaneousPushViewController: UIViewController {
    var animator: UIDynamicAnimator!
    var pushBehavior: UIPushBehavior!

    @IBOutlet weak var square1: UIImageView!

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        let animator = UIDynamicAnimator(referenceView: view)

        let collisionBehavior = UICollisionBehavior(items: [square1])
        collisionBehavior.setTranslatesReferenceBoundsIntoBoundaryWithInsets(UIEdgeInsetsMake(topLayoutGuide.length, 0, bottomLayoutGuide.length, 0))
        animator.addBehavior(collisionBehavior)

        let pushBehavior = UIPushBehavior(items: [square1], mode: UIPushBehaviorMode.Instantaneous)
        pushBehavior.angle = 0.0
        pushBehavior.magnitude = 0.0
        animator.addBehavior(pushBehavior)

        self.animator = animator
        self.pushBehavior = pushBehavior
    }

    //| ----------------------------------------------------------------------------
    //  IBAction for the Tap Gesture Recognizer that has been configured to track
    //  touches in self.view.
    //
    @IBAction func handlePushGesture(gesture: UITapGestureRecognizer) {
        // Tapping will change the angle and magnitude of the impulse. To visually
        // show the impulse vector on screen, a red arrow representing the angle
        // and magnitude of this vector is briefly drawn.
        let p:CGPoint = gesture.locationInView(view)
        let o:CGPoint = CGPointMake(CGRectGetMidX(view.bounds), CGRectGetMidY(view.bounds))
        var distance = sqrtf(powf(Float(p.x - o.x), 2.0)+powf(Float(p.y - o.y), 2.0))
        let angle = atan2(p.y-o.y, p.x-o.x)
        distance = min(distance, 100.0)

        // Display an arrow showing the direction and magnitude of the applied
        // impulse.
        let decorationView = view as! APLDecorationView
        decorationView.drawMagnitudeVectorWithLength(CGFloat(distance), angle: angle, color: UIColor.redColor(), forLimitedTime: true)

        // These two lines change the actual force vector.
        pushBehavior.magnitude = CGFloat(distance) / 100.0
        pushBehavior.angle = angle
        // A push behavior in instantaneous (impulse) mode automatically
        // deactivate itself after applying the impulse. We thus need to reactivate
        // it when changing the impulse vector.
        pushBehavior.active = true
    }
}
