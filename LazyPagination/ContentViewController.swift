//
//  ContentViewController.swift
//  LazyPagination
//
//  Created by Aaron Lee on 2022/07/09.
//

import UIKit

class ContentViewController: UIViewController {
  
  convenience init(title: String) {
    self.init(nibName: nil, bundle: nil)
    self.title = title
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    guard let title = title else {
      print("Title not initialized.")
      return
    }
    
    print("Title initialized with \(title)")
    
    guard let page = Int(title.split(separator: " ")[1]) else {
      view.backgroundColor = .red
      return
    }
    
    view.backgroundColor = [UIColor.orange, UIColor.gray, UIColor.green, UIColor.brown, UIColor.purple][page - 1]
  }
}
