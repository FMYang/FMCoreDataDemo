//
//  UIView.swift
//  FMCoreDataStudy
//
//  Created by yfm on 2022/12/16.
//

import Foundation
import UIKit

extension UIView {
    func addRoundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: CGRect(x: 20, y: 0, width: bounds.width-40, height: bounds.height), byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    func withOutRound() {
        layer.mask = nil
    }
}
