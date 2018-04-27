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
  var homeButton: UIButton?
  var isShowingMenu = false

  override func viewDidLoad() {
    super.viewDidLoad()
    setupHomeButton()
  }
  
  @objc func homeButtonAction(_ sender: UIButton) {
    squezeeStackView()
    rotateHomeButton()
  }
  
  private func animateMenu() {
    
    func animateToShowMenu() {
      
    }
    
    func animateToHideMenu() {
      
    }
    
    !isShowingMenu ? animateToShowMenu() : animateToHideMenu()
  }
  
  private func rotateHomeButton() {
    if let button = homeButton {
      UIView.animate(withDuration: 0.5, animations: {
        button.transform = button.transform.rotated(by: (.pi / 6) * 2)
      }, completion: nil)
    }
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
    let homeButtonImage = HexagonalHomeButton.imageForSize(homeButtonContainerView.frame.size, color: color)
    homeButton = UIButton(frame: CGRect(x: 0, y: 0, width: homeButtonContainerView.frame.size.width, height: homeButtonContainerView.frame.size.height))
    homeButton?.addTarget(self, action: #selector(homeButtonAction), for: .touchUpInside)
    homeButton?.setImage(homeButtonImage, for: .normal)
    homeButton?.layer.shadowColor = color.cgColor
    homeButton?.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
    homeButton?.layer.shadowRadius = 7.0
    homeButton?.layer.shadowOpacity = 0.6
    homeButton?.adjustsImageWhenHighlighted = false
    if let button = homeButton {
      homeButtonContainerView.addSubview(button)
    }
  }
}

