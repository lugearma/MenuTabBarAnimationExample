//
//  ViewController.swift
//  MenuTabBarExample
//
//  Created by Luis Arias on 4/27/18.
//  Copyright © 2018 Luis Arias. All rights reserved.
//

import UIKit

struct ViewControllerUIConstants {
  static let purpleColor = UIColor(red: 162/255, green: 164/255, blue: 215/255, alpha: 1.0)
  static let squezeeConstant: CGFloat = 5
}

final class ViewController: UIViewController {
  
  @IBOutlet weak var homeButtonContainerView: UIView!
  @IBOutlet weak var leftStackViewConstraint: NSLayoutConstraint!
  @IBOutlet weak var rightStackViewConstraint: NSLayoutConstraint!

  override func viewDidLoad() {
    super.viewDidLoad()
    setupHomeButton()
  }
  
  @objc func homeButtonAction(_ sender: UIButton) {
    squezeeStackView()
  }
  
  private func squezeeStackView() {
    leftStackViewConstraint.constant += ViewControllerUIConstants.squezeeConstant
    rightStackViewConstraint.constant += ViewControllerUIConstants.squezeeConstant
    UIView.animate(withDuration: 0.5, delay: 0.0, options: [], animations: {
      self.view.layoutIfNeeded()
    }) { _ in
      self.leftStackViewConstraint.constant -= ViewControllerUIConstants.squezeeConstant
      self.rightStackViewConstraint.constant -= ViewControllerUIConstants.squezeeConstant
      UIView.animate(withDuration: 0.3){
       self.view.layoutIfNeeded()
      }
    }
  }
  
  // TODO: Create this button inside HexagonalHomeButton class
  func setupHomeButton() {
    let color = ViewControllerUIConstants.purpleColor
    let homeButton = HexagonalHomeButton.imageForSize(homeButtonContainerView.frame.size, color: color)
    let button = UIButton(frame: CGRect(x: 0, y: 0, width: homeButtonContainerView.frame.size.width, height: homeButtonContainerView.frame.size.height))
    button.addTarget(self, action: #selector(homeButtonAction), for: .touchUpInside)
    button.setImage(homeButton, for: .normal)
    button.layer.shadowColor = color.cgColor
    button.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
    button.layer.shadowRadius = 7.0
    button.layer.shadowOpacity = 0.6
    homeButtonContainerView.addSubview(button)
  }
}

