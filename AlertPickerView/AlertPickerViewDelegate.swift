//
//  AlertPickerViewDelegate.swift
//  AlertPickerView
//
//  Created by 松山 友也 on 2018/11/12.
//  Copyright © 2018年 松山 友也. All rights reserved.
//

import Foundation
import UIKit

public class AlertPickerViewDelegate: NSObject {}

extension AlertPickerViewDelegate: UIViewControllerTransitioningDelegate {
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        let animator = AlertPickerAnimator(forPresented: true)

        return animator
    }

    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animator = AlertPickerAnimator(forPresented: false)

        return animator
    }
}
