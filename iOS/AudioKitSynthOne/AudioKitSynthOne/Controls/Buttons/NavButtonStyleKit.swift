//
//  NavButtonStyleKit.swift
//  AudioKitSynthOne
//
//  Created by Matthew Fecher on 10/20/17.
//  Copyright © 2017 AudioKit. All rights reserved.
//
//  Generated by PaintCode
//  http://www.paintcodeapp.com
//



import UIKit

public class NavButtonStyleKit : NSObject {

    //// Drawing Methods

    @objc dynamic public class func drawNavButton(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 53, height: 156), resizing: ResizingBehavior = .aspectFit, isOn: CGFloat = 0, rotation: CGFloat = 180, text: String = "ADSR") {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 53, height: 156), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 53, y: resizedFrame.height / 156)


        //// Color Declarations
        let selectedColor = UIColor(red: 0.341, green: 0.349, blue: 0.345, alpha: 1.000)
        let offColor = UIColor(red: 0.278, green: 0.286, blue: 0.282, alpha: 1.000)
        let labelColor = UIColor(red: 0.667, green: 0.667, blue: 0.667, alpha: 1.000)
        let triangle = UIColor(red: 0.400, green: 0.400, blue: 0.400, alpha: 1.000)

        //// Variable Declarations
        let upSelected = isOn == 1 ? selectedColor : offColor

        //// Button
        //// btnBackground Drawing
        let btnBackgroundPath = UIBezierPath(rect: CGRect(x: 0.5, y: 1, width: 50, height: 150))
        upSelected.setFill()
        btnBackgroundPath.fill()
        UIColor.black.setStroke()
        btnBackgroundPath.lineWidth = 1
        btnBackgroundPath.stroke()


        //// arrow Drawing
        context.saveGState()
        context.translateBy(x: 25.5, y: 85)
        context.rotate(by: -rotation * CGFloat.pi/180)

        let arrowPath = UIBezierPath()
        arrowPath.move(to: CGPoint(x: 12.5, y: -15))
        arrowPath.addLine(to: CGPoint(x: -12.5, y: 0))
        arrowPath.addLine(to: CGPoint(x: 12.5, y: 15))
        triangle.setFill()
        arrowPath.fill()

        context.restoreGState()


        //// label Drawing
        let labelRect = CGRect(x: 0, y: 36, width: 50, height: 21)
        let labelStyle = NSMutableParagraphStyle()
        labelStyle.alignment = .center
        let labelFontAttributes = [
            NSFontAttributeName: UIFont(name: "AvenirNextCondensed-Regular", size: UIFont.labelFontSize)!,
            NSForegroundColorAttributeName: labelColor,
            NSParagraphStyleAttributeName: labelStyle,
        ]

        let labelTextHeight: CGFloat = text.boundingRect(with: CGSize(width: labelRect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: labelFontAttributes, context: nil).height
        context.saveGState()
        context.clip(to: labelRect)
        text.draw(in: CGRect(x: labelRect.minX, y: labelRect.minY + (labelRect.height - labelTextHeight) / 2, width: labelRect.width, height: labelTextHeight), withAttributes: labelFontAttributes)
        context.restoreGState()
        
        context.restoreGState()

    }




    @objc(NavButtonStyleKitResizingBehavior)
    public enum ResizingBehavior: Int {
        case aspectFit /// The content is proportionally resized to fit into the target rectangle.
        case aspectFill /// The content is proportionally resized to completely fill the target rectangle.
        case stretch /// The content is stretched to match the entire target rectangle.
        case center /// The content is centered in the target rectangle, but it is NOT resized.

        public func apply(rect: CGRect, target: CGRect) -> CGRect {
            if rect == target || target == CGRect.zero {
                return rect
            }

            var scales = CGSize.zero
            scales.width = abs(target.width / rect.width)
            scales.height = abs(target.height / rect.height)

            switch self {
                case .aspectFit:
                    scales.width = min(scales.width, scales.height)
                    scales.height = scales.width
                case .aspectFill:
                    scales.width = max(scales.width, scales.height)
                    scales.height = scales.width
                case .stretch:
                    break
                case .center:
                    scales.width = 1
                    scales.height = 1
            }

            var result = rect.standardized
            result.size.width *= scales.width
            result.size.height *= scales.height
            result.origin.x = target.minX + (target.width - result.width) / 2
            result.origin.y = target.minY + (target.height - result.height) / 2
            return result
        }
    }
}
