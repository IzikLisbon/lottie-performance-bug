//
//  UIView+extension.swift
//  lottie_performance_bug
//
//  Created by Izik Lisbon on 12/24/19.
//  Copyright © 2019 lottie-bug. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
  func stretchToContainerEdges() {
    guard let superview = superview else { return }
    topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor, constant: 0)
    leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 0)
    trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: 0)
    bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: 0)
  }
}
