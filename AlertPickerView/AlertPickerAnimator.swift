//
//  AlertPickerAnimator.swift
//  AlertPickerView
//
//  Created by 松山 友也 on 2018/11/12.
//  Copyright © 2018年 松山 友也. All rights reserved.
//

import Foundation
import UIKit

class AlertPickerAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    let forPresented: Bool

    init(forPresented: Bool) {
        self.forPresented = forPresented
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return Const.duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from) else { return }
        guard let toVC = transitionContext.viewController(forKey: .to) else { return }

        if forPresented {
            presentAnimation(using: transitionContext, to: toVC.view, from: fromVC.view)
        } else {
            dismissAnimation(using: transitionContext, to: toVC.view, from: fromVC.view)
        }
    }

    private func presentAnimation(using transitionContext: UIViewControllerContextTransitioning, to toView: UIView, from fromView: UIView) {

        let containerView = transitionContext.containerView

        containerView.addSubview(toView)

        toView.frame = containerView.frame
        toView.backgroundColor = UIColor.black.withAlphaComponent(0)
        toView.bounds.origin.y = -containerView.frame.height

        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, options: .curveEaseOut, animations: {
            toView.bounds.origin.y += containerView.frame.height
            toView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            
        }, completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }

    private func dismissAnimation(using transitionContext: UIViewControllerContextTransitioning, to toView: UIView, from fromView: UIView) {

        let containerView = transitionContext.containerView

        UIView.animate(withDuration: transitionDuration(using: transitionContext) * 1.8, delay: 0, options: .curveEaseOut, animations: {
            fromView.bounds.origin.y -= containerView.frame.height
            fromView.backgroundColor = UIColor.black.withAlphaComponent(0)

        }, completion: { _ in
            fromView.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })

    }
}

extension AlertPickerAnimator {
    private enum Const {
        static let duration: TimeInterval = 0.4
    }
}
