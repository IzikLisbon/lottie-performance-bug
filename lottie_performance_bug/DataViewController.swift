//
//  DataViewController.swift
//  lottie_performance_bug
//
//  Created by Izik Lisbon on 12/23/19.
//  Copyright © 2019 lottie-bug. All rights reserved.
//

import UIKit

class DataViewController: UIViewController {

  @IBOutlet weak var dataLabel: UILabel!
  var dataObject: String = ""


  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.dataLabel!.text = dataObject
  }


}

