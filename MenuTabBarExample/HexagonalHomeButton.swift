//
//  HexagonalHomeButton.swift
//  MenuTabBarExample
//
//  Created by Luis Arias on 4/27/18.
//  Copyright © 2018 Luis Arias. All rights reserved.
//

import UIKit

final class HexagonalHomeButton: UIView {
  
  let color: UIColor
  
  init(frame: CGRect, color: UIColor) {
    self.color = color
    super.init(frame: frame)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func draw(_ rect: CGRect) {
    color.setStroke()
    let path = roundedPolygonPath(rect: rect, sides: 6, cornerRadius: 2)
    path.stroke()
  }
  
  private func roundedPolygonPath(rect: CGRect, sides: Int, cornerRadius: CGFloat, rotationOffset: CGFloat = 0, lineWidth: CGFloat = 1) -> UIBezierPath {
    let path = UIBezierPath()
    let theta: CGFloat = CGFloat(2.0 * .pi) / CGFloat(sides)
    let width = min(rect.size.width, rect.size.height)
    
    let center = CGPoint(x: rect.origin.x + width / 2.0, y: rect.origin.y + width / 2.0)
    let radius = (width - lineWidth + cornerRadius - (cos(theta) * cornerRadius)) / 2.0
    var angle = CGFloat(rotationOffset)
    let corner = CGPoint(x: center.x + (radius - cornerRadius) * cos(angle), y: center.y + (radius - cornerRadius) * sin(angle))
    path.move(to: CGPoint(x: corner.x + cornerRadius * cos(angle + theta), y: corner.y + cornerRadius * sin(angle + theta)))
    
    for _ in 0..<sides {
      angle += theta
      let corner = CGPoint(x: center.x + (radius - cornerRadius) * cos(angle), y: center.y + (radius - cornerRadius) * sin(angle))
      let tip = CGPoint(x: center.x + radius * cos(angle), y: center.y + radius * sin(angle))
      let start = CGPoint(x: corner.x + cornerRadius * cos(angle - theta), y: corner.y + cornerRadius * sin(angle - theta))
      let end = CGPoint(x: corner.x + cornerRadius * cos(angle + theta), y: corner.y + cornerRadius * sin(angle + theta))
      
      path.addLine(to: start)
      path.addQuadCurve(to: end, controlPoint: tip)
    }
    path.close()
    
    return path
  }
  
  class func imageForSize(_ size: CGSize, color: UIColor) -> UIImage? {
    let frame = CGRect(origin: .zero, size: size)
    let view = HexagonalHomeButton(frame: frame, color: color)
    view.backgroundColor = .clear
    UIGraphicsBeginImageContextWithOptions(size, false, 0)
    view.drawHierarchy(in: frame, afterScreenUpdates: true)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image
  }
}
