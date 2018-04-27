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
}

final class ViewController: UIViewController {
  
  @IBOutlet weak var homeButtonContainerView: UIView!
  @IBOutlet weak var leftStackViewConstraint: NSLayoutConstraint!
  @IBOutlet weak var rightStackViewConstraint: NSLayoutConstraint!

  override func viewDidLoad() {
    super.viewDidLoad()
    setupHomeButton()
  }
  
  @IBAction func plusButtonTapped(_ sender: UIButton) {
    squezeeStackView()
  }
  
  private func squezeeStackView() {
    leftStackViewConstraint.constant += 20
    rightStackViewConstraint.constant += 20
    UIView.animate(withDuration: 0.3, delay: 0.0, options: [], animations: {
      self.view.layoutIfNeeded()
    }) { _ in
      self.leftStackViewConstraint.constant -= 20
      self.rightStackViewConstraint.constant -= 20
      UIView.animate(withDuration: 0.3){
       self.view.layoutIfNeeded()
      }
    }
  }
  
  func setupHomeButton() {
    let homeButton = HexagonalHomeButton.imageForSize(homeButtonContainerView.frame.size, color: ViewControllerUIConstants.purpleColor)
    let imageView = UIImageView(image: homeButton)
    homeButtonContainerView.addSubview(imageView)
    let rotation = CGAffineTransform(rotationAngle: 11)
    homeButtonContainerView.transform = rotation
  }
}

