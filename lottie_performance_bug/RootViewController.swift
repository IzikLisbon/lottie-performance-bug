//
//  RootViewController.swift
//  lottie_performance_bug
//
//  Created by Izik Lisbon on 12/23/19.
//  Copyright © 2019 lottie-bug. All rights reserved.
//

import UIKit

class RootViewController: UIViewController, UIPageViewControllerDelegate {

  var pageViewController: UIPageViewController?


  override func viewDidLoad() {
    super.viewDidLoad()
    setupNavigationBarButtons()
    self.pageViewController = UIPageViewController(transitionStyle: .pageCurl, navigationOrientation: .horizontal, options: nil)
    self.pageViewController!.delegate = self
    let startingViewController: PageViewController = self.modelController.viewControllerAtIndex(0, storyboard: self.storyboard!)!
    let viewControllers = [startingViewController]
    self.pageViewController!.setViewControllers(viewControllers, direction: .forward, animated: false, completion: {done in })
    self.pageViewController!.dataSource = self.modelController

    // load all pages
    for i in 0..<modelController.pageData.count {
      let viewController = modelController.viewControllerAtIndex(i, storyboard: UIStoryboard(name: "Main", bundle: nil))!
      let _ = viewController.view
    }

    self.addChild(self.pageViewController!)
    self.view.addSubview(self.pageViewController!.view)

    var pageViewRect = self.view.bounds
    if UIDevice.current.userInterfaceIdiom == .pad {
        pageViewRect = pageViewRect.insetBy(dx: 40.0, dy: 40.0)
    }

    self.pageViewController!.didMove(toParent: self)
    self.pageViewController!.view.stretchToContainerEdges()
  }

  private func setupNavigationBarButtons() {
    let leftButton = UIBarButtonItem(title: "Pause Animation", style: .plain, target: self, action: #selector(togglePauseAndStopAnimations))
    let rightButton = UIBarButtonItem(title: "Remove Lottie", style: .plain, target: self, action: #selector(toggleLottieAndStaticImage))
    navigationItem.leftBarButtonItem = leftButton
    navigationItem.rightBarButtonItem = rightButton
  }

  @objc private func togglePauseAndStopAnimations() {
    for i in 0..<modelController.pageData.count {
      let viewController = modelController.viewControllerAtIndex(i, storyboard: UIStoryboard(name: "Main", bundle: nil))!
      viewController.togglePauseAndStopAnimation()
      navigationItem.leftBarButtonItem?.title = viewController.isAnimating ? "Pause Animation" : "Start Animation"
    }
  }

  @objc private func toggleLottieAndStaticImage() {
    for i in 0..<modelController.pageData.count {
      let viewController = modelController.viewControllerAtIndex(i, storyboard: UIStoryboard(name: "Main", bundle: nil))!
      viewController.toggleLottieAndStaticImage()

      if viewController.animationView == nil {
        navigationItem.rightBarButtonItem?.title = "Add Lottie"
      } else {
        navigationItem.rightBarButtonItem?.title = "Remove Lottie"
        navigationItem.leftBarButtonItem?.title = "Pause Animation"
      }
    }
  }

  var modelController: PagesManager {
    if _modelController == nil {
        _modelController = PagesManager()
    }
    return _modelController!
  }

  var _modelController: PagesManager? = nil

  // MARK: - UIPageViewController delegate methods

  func pageViewController(_ pageViewController: UIPageViewController, spineLocationFor orientation: UIInterfaceOrientation) -> UIPageViewController.SpineLocation {
    if (orientation == .portrait) || (orientation == .portraitUpsideDown) || (UIDevice.current.userInterfaceIdiom == .phone) {
        let currentViewController = self.pageViewController!.viewControllers![0]
        let viewControllers = [currentViewController]
        self.pageViewController!.setViewControllers(viewControllers, direction: .forward, animated: true, completion: {done in })

        self.pageViewController!.isDoubleSided = false
        return .min
    }

    let currentViewController = self.pageViewController!.viewControllers![0] as! PageViewController
    var viewControllers: [UIViewController]

    let indexOfCurrentViewController = self.modelController.indexOfViewController(currentViewController)
    if (indexOfCurrentViewController == 0) || (indexOfCurrentViewController % 2 == 0) {
        let nextViewController = self.modelController.pageViewController(self.pageViewController!, viewControllerAfter: currentViewController)
        viewControllers = [currentViewController, nextViewController!]
    } else {
        let previousViewController = self.modelController.pageViewController(self.pageViewController!, viewControllerBefore: currentViewController)
        viewControllers = [previousViewController!, currentViewController]
    }
    self.pageViewController!.setViewControllers(viewControllers, direction: .forward, animated: true, completion: {done in })

    return .mid
  }


}

