//
//  DataViewController.swift
//  lottie_performance_bug
//
//  Created by Izik Lisbon on 12/23/19.
//  Copyright © 2019 lottie-bug. All rights reserved.
//

import UIKit
import Lottie

class DataViewController: UIViewController {
  @IBOutlet weak var dataLabel: UILabel!
  var dataObject: String = ""
  var animationView: AnimationView?
  var imageView: UIImageView?
  @IBOutlet weak var contentView: UIView!
  var boolIsAnimating = true

  override func viewDidLoad() {
    super.viewDidLoad()
    addLottie()
  }

  func togglePauseAndStopAnimation() {
    if boolIsAnimating {
      boolIsAnimating = false
      animationView?.stop()
    } else {
      boolIsAnimating = true
      animationView?.play()
    }
  }

  func toggleLottieAndStaticImage() {
    if animationView == nil {
      imageView?.removeFromSuperview()
      imageView = nil
      addLottie()
    } else {
      animationView?.removeFromSuperview()
      animationView = nil
      addStaticView()
    }
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.dataLabel!.text = dataObject
  }

  private func addStaticView() {
    let view: UIImageView = UIImageView()
    view.contentMode = .scaleAspectFit
    view.translatesAutoresizingMaskIntoConstraints = false
    view.image = UIImage.imageWithSize(size: CGSize(width: 500, height: 600), color: .blue)
    contentView.addSubview(view)
    view.stretchToContainerEdges()
    imageView = view
  }

  private func addLottie() {
    if let animation = Animation.named("medium_animation", bundle: Bundle.main) {
      let view: AnimationView = AnimationView()
      view.loopMode = .loop
      view.backgroundColor = UIColor.white
      view.animation = animation
      view.shouldRasterizeWhenIdle = true // Tried both true and false, results were the same.  
      view.contentMode = .scaleAspectFit
      view.translatesAutoresizingMaskIntoConstraints = false
      self.animationView = view
      contentView.addSubview(view)
      view.stretchToContainerEdges()
      self.animationView?.play()
    }
  }
}



extension UIImage {
  static func imageWithSize(size : CGSize, color : UIColor = UIColor.white) -> UIImage? {
    var image:UIImage? = nil
    UIGraphicsBeginImageContext(size)
    if let context = UIGraphicsGetCurrentContext() {
      context.setFillColor(color.cgColor)
      context.addRect(CGRect(origin: CGPoint.zero, size: size));
      context.drawPath(using: .fill)
      image = UIGraphicsGetImageFromCurrentImageContext();
    }
    UIGraphicsEndImageContext()
    return image
  }
}
