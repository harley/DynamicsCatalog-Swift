//
//  CollisionsGravitySpringViewController.swift
//  DynamicsCatalog
//
//  Created by Harley Trung on 12/28/15.
//  Copyright © 2015 Apple Inc. All rights reserved.
//

import UIKit

class CollisionsGravitySpringViewController: UIViewController {
    var animator: UIDynamicAnimator!

    @IBOutlet weak var square1: UIView!
    @IBOutlet weak var attachmentView: UIImageView!
    @IBOutlet weak var square1AttachmentView: UIImageView!
    var attachmentBehavior: UIAttachmentBehavior!

    override func viewDidLoad() {
        super.viewDidLoad()

        let animator = UIDynamicAnimator(referenceView: view)
        let gravityBehavior = UIGravityBehavior(items: [square1])

        let collisionBehavior = UICollisionBehavior(items: [square1])
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true

        let anchorPoint = CGPointMake(square1.center.x, square1.center.y - 110.0)
        let attachmentBehavior = UIAttachmentBehavior(item: square1, attachedToAnchor: anchorPoint)
        attachmentBehavior.frequency = 1.0
        attachmentBehavior.damping = 0.1

        // visually show the attachment point
        attachmentView.center = attachmentBehavior.anchorPoint
        attachmentView.tintColor = UIColor.redColor()
        attachmentView.image = attachmentView.image?.imageWithRenderingMode(.AlwaysTemplate)

        // visually show the attachment point
        square1AttachmentView.center = CGPointMake(50.0, 50.0)
        square1AttachmentView.tintColor = UIColor.blueColor()
        square1AttachmentView.image = attachmentView.image?.imageWithRenderingMode(.AlwaysTemplate)

        // visually show the connection between the attachment points.
        let decorationView = view as! APLDecorationView
        decorationView.trackAndDrawAttachmentFromView(attachmentView, toView: square1, withAttachmentOffset: CGPointZero)

        animator.addBehavior(attachmentBehavior)
        animator.addBehavior(collisionBehavior)
        animator.addBehavior(gravityBehavior)

        self.animator = animator
        self.attachmentBehavior = attachmentBehavior

    }

    //| ----------------------------------------------------------------------------
    //  IBAction for the Pan Gesture Recognizer and Tap Gesture Recognizer that have
    //  been configured to track touches in self.view.  (Both types of gesture
    //  recognizers are used so that square1AttachmentView is repositioned
    //  immediately in response to a new touch, instead of waiting for that touch
    //  to be recognized as a drag.)
    //
    @IBAction func handleSpringAttachmentGesture(gesture: UIGestureRecognizer) {
        attachmentBehavior.anchorPoint = gesture.locationInView(view)
        attachmentView.center = self.attachmentBehavior.anchorPoint
    }
}