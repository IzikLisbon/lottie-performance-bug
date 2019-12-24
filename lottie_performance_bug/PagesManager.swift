//
//  PagesManager.swift
//  lottie_performance_bug
//
//  Created by Izik Lisbon on 12/23/19.
//  Copyright © 2019 lottie-bug. All rights reserved.
//

import UIKit

// Managing the pages in the UIPageViewController.
class PagesManager: NSObject, UIPageViewControllerDataSource {

  var pageData: [String] = ["1", "2", "3"]
  var pageControllers: [PageViewController] = []

  func viewControllerAtIndex(_ index: Int, storyboard: UIStoryboard) -> PageViewController? {
    // Return the data view controller for the given index.
    if (self.pageData.count == 0) || (index >= self.pageData.count) {
        return nil
    }

    if index < pageControllers.count {
      return pageControllers[index]
    }

    // Create a new view controller and pass suitable data.
    let dataViewController = storyboard.instantiateViewController(withIdentifier: "PageViewController") as! PageViewController
    dataViewController.dataObject = self.pageData[index]
    pageControllers.append(dataViewController)
    return dataViewController
  }

  func indexOfViewController(_ viewController: PageViewController) -> Int {
    // Return the index of the given data view controller.
    // For simplicity, this implementation uses a static array of model objects and the view controller stores the model object; you can therefore use the model object to identify the index.
    return pageData.firstIndex(of: viewController.dataObject) ?? NSNotFound
  }

  // MARK: - Page View Controller Data Source

  func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
      var index = self.indexOfViewController(viewController as! PageViewController)
      if (index == 0) || (index == NSNotFound) {
          return nil
      }
      
      index -= 1
      return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
  }

  func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
      var index = self.indexOfViewController(viewController as! PageViewController)
      if index == NSNotFound {
          return nil
      }
      
      index += 1
      if index == self.pageData.count {
          return nil
      }
      return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
  }

}

