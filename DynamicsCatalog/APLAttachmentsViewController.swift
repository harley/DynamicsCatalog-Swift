//
//  APLAttachmentsViewController.swift
//  DynamicsCatalog
//
//  Created by Harley Trung on 12/28/15.
//  Copyright © 2015 Apple Inc. All rights reserved.
//

import UIKit

class APLAttachmentsViewController: UIViewController {
    @IBOutlet weak var square1: UIView!
    @IBOutlet weak var square1AttachmentView: UIImageView!
    @IBOutlet weak var attachmentView: UIImageView!
    var animator: UIDynamicAnimator!
    var attachmentBehavior: UIAttachmentBehavior!

    override func viewDidLoad() {
        super.viewDidLoad()

        let animator = UIDynamicAnimator(referenceView: view)

        // Creates collision boundaries from the bounds of the dynamic animator's
        let collisionBehavior = UICollisionBehavior(items: [square1])
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collisionBehavior)

        let squareCenterPoint = CGPointMake(square1.center.x, square1.center.y - 110.0)
        let attachmentPoint: UIOffset = UIOffsetMake(-25.0, -25.0)

        // By default, an attachment behavior uses the center of a view. By using a
        // small offset, we get a more interesting effect which will cause the view
        // to have rotation movement when dragging the attachment.

        let attachmentBehavior = UIAttachmentBehavior(item: square1, offsetFromCenter: attachmentPoint, attachedToAnchor: squareCenterPoint)
        animator.addBehavior(attachmentBehavior)
        self.attachmentBehavior = attachmentBehavior


        // Visually show the attachment points
        attachmentView.center = attachmentBehavior.anchorPoint
        print("attachmentView center", attachmentView.center)
        attachmentView.tintColor = UIColor.redColor()
        attachmentView.image = attachmentView.image?.imageWithRenderingMode(.AlwaysTemplate)

        square1AttachmentView.center = CGPointMake(25.0, 25.0)
        square1AttachmentView.tintColor = UIColor.blueColor()
        square1AttachmentView.image = square1AttachmentView.image?.imageWithRenderingMode(.AlwaysTemplate)

        // Visually show the connection between the attachment points.
        let decorationView = view as! APLDecorationView
        decorationView.trackAndDrawAttachmentFromView(attachmentView, toView: square1, withAttachmentOffset: CGPointMake(-25.0, -25.0))

        self.animator = animator
    }

    //| ----------------------------------------------------------------------------
    //  IBAction for the Pan Gesture Recognizer that has been configured to track
    //  touches in self.view.
    //
    @IBAction func handleAttachmentGesture(gesture: UIPanGestureRecognizer) {
        attachmentBehavior.anchorPoint = gesture.locationInView(view)
        attachmentView.center = attachmentBehavior.anchorPoint
    }
}
