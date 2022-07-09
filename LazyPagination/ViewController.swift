//
//  ViewController.swift
//  LazyPagination
//
//  Created by Aaron Lee on 2022/07/09.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

class ViewController: UIViewController {
  
  private var bag = DisposeBag()
  
  private let scrollView = UIScrollView()
    .then {
      $0.isPagingEnabled = true
    }
  
  private let contentView = UIView()
  
  private let contentStackView = UIStackView()
    .then {
      $0.alignment = .fill
      $0.distribution = .fill
      $0.spacing = .zero
      $0.axis = .horizontal
    }
  
  private lazy var contentViewControllers: Array<ContentViewController> = [
    ContentViewController(title: "Menu 1"),
    ContentViewController(title: "Menu 2"),
    ContentViewController(title: "Menu 3"),
    ContentViewController(title: "Menu 4"),
    ContentViewController(title: "Menu 5")
  ]
  
  private var loadedContentViewControllerIndexes: Set<Int> = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureViews()
    layoutViews()
    loadContentViewController(at: 0)
    
    bindScroll()
  }
  
  private func configureViews() {
    view.addSubview(scrollView)
    scrollView.addSubview(contentView)
    contentView.addSubview(contentStackView)
  }
  
  private func layoutViews() {
    layoutScrollView()
    layoutContentView()
    layoutContentStackView()
  }
  
  private func layoutScrollView() {
    scrollView.snp.makeConstraints {
      $0.top.equalToSuperview()
      $0.leading.trailing.bottom.equalToSuperview()
      $0.width.equalToSuperview().priority(.low)
    }
  }
  
  private func layoutContentView() {
    contentView.snp.makeConstraints {
      $0.edges.equalToSuperview()
      $0.height.equalToSuperview()
      $0.width.equalToSuperview().multipliedBy(contentViewControllers.count)
    }
  }
  
  private func layoutContentStackView() {
    contentStackView.snp.makeConstraints {
      $0.top.leading.bottom.equalToSuperview()
      $0.trailing.lessThanOrEqualToSuperview()
    }
  }
  
  private func loadContentViewController(at page: Int) {
    guard let viewController = contentViewControllers[safe: page],
          !loadedContentViewControllerIndexes.contains(page) else {
      return
    }
    
    contentViewControllers.append(viewController)
    
    loadedContentViewControllerIndexes.insert(page)
    
    addChild(viewController)
    contentStackView.addArrangedSubview(viewController.view)
    viewController.willMove(toParent: self)
    viewController.didMove(toParent: self)
    
    viewController.view.snp.makeConstraints {
      $0.width.equalTo(view.safeAreaLayoutGuide)
    }
  }
  
  private func bindScroll() {
    scrollView.rx.didEndDecelerating
      .withUnretained(self)
      .bind(onNext: { owner, _ in
        let pageWidth = owner.scrollView.frame.width
        let page = Int(floor((owner.scrollView.contentOffset.x - pageWidth) / pageWidth) + 1)
        
        print("Current page: \(page)")
        
        owner.loadContentViewController(at: page)
      })
      .disposed(by: bag)
  }
}
