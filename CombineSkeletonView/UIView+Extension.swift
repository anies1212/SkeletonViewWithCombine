//
//  UIView+Extension.swift
//  CombineSkeletonView
//
//  Created by 新垣 清奈 on 2022/09/21.
//

import Foundation
import UIKit

extension UIView {

    func pinToParent(parent: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        parent.addSubview(self)
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: parent.topAnchor),
            leadingAnchor.constraint(equalTo: parent.leadingAnchor),
            trailingAnchor.constraint(equalTo: parent.trailingAnchor),
            bottomAnchor.constraint(equalTo: parent.bottomAnchor)
        ])
    }

    func removeAllSubViews(){
        subviews.forEach { $0.removeFromSuperview() }
    }
}
