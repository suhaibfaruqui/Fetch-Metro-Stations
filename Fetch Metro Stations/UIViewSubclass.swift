//
//  UIViewSubclass.swift
//  Fetch Metro Stations
//
//  Created by Suhaib Umar on 5/11/16.
//  Copyright © 2016 Suhaib. All rights reserved.
//

import UIKit

class UIViewSubclass: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    override func drawRect(rect: CGRect) {
        super.drawRect(rect) // optional if a direct UIView-subclass, should be called otherwise.
        
        let HEIGHTOFPOPUPTRIANGLE:CGFloat = 8
        let WIDTHOFPOPUPTRIANGLE:CGFloat = 10
        let borderRadius:CGFloat = 15
        let strokeWidth:CGFloat = 2.0
        
        // Get the context
        let context: CGContextRef = UIGraphicsGetCurrentContext()!
        CGContextTranslateCTM(context, 0.0, self.bounds.size.height)
        CGContextScaleCTM(context, 1.0, -1.0)
        //
        //self.bounds.height = self.bounds.height + 10
        var currentFrame: CGRect = self.bounds
        currentFrame.size.height = currentFrame.size.height
        CGContextSetLineJoin(context, CGLineJoin.Round)
        CGContextSetLineWidth(context, strokeWidth)
        CGContextSetStrokeColorWithColor(context, UIColor.blackColor().CGColor)
        CGContextSetFillColorWithColor(context, UIColor(red: 0.5, green: 0.8, blue: 1, alpha: 0.8).CGColor)
        // Draw and fill the bubble
        CGContextBeginPath(context)
        CGContextMoveToPoint(context, borderRadius + strokeWidth + 0.5, strokeWidth + HEIGHTOFPOPUPTRIANGLE + 0.5)
        CGContextAddLineToPoint(context, round(currentFrame.size.width / 2.0 - WIDTHOFPOPUPTRIANGLE / 2.0) + 0.5, HEIGHTOFPOPUPTRIANGLE + strokeWidth + 0.5)
        CGContextAddLineToPoint(context, round(currentFrame.size.width / 2.0) + 0.5, strokeWidth + 0.5)
        CGContextAddLineToPoint(context, round(currentFrame.size.width / 2.0 + WIDTHOFPOPUPTRIANGLE / 2.0) + 0.5, HEIGHTOFPOPUPTRIANGLE + strokeWidth + 0.5)
        CGContextAddArcToPoint(context, currentFrame.size.width - strokeWidth - 0.5, strokeWidth + HEIGHTOFPOPUPTRIANGLE + 0.5, currentFrame.size.width - strokeWidth - 0.5, currentFrame.size.height - strokeWidth - 0.5, borderRadius - strokeWidth)
        CGContextAddArcToPoint(context, currentFrame.size.width - strokeWidth - 0.5, currentFrame.size.height - strokeWidth - 0.5, round(currentFrame.size.width / 2.0 + WIDTHOFPOPUPTRIANGLE / 2.0) - strokeWidth + 0.5, currentFrame.size.height - strokeWidth - 0.5, borderRadius - strokeWidth)
        CGContextAddArcToPoint(context, strokeWidth + 0.5, currentFrame.size.height - strokeWidth - 0.5, strokeWidth + 0.5, HEIGHTOFPOPUPTRIANGLE + strokeWidth + 0.5, borderRadius - strokeWidth)
        CGContextAddArcToPoint(context, strokeWidth + 0.5, strokeWidth + HEIGHTOFPOPUPTRIANGLE + 0.5, currentFrame.size.width - strokeWidth - 0.5, HEIGHTOFPOPUPTRIANGLE + strokeWidth + 0.5, borderRadius - strokeWidth)
        CGContextClosePath(context)
        CGContextDrawPath(context, CGPathDrawingMode.FillStroke)
        
        // Draw a clipping path for the fill
        CGContextBeginPath(context)
        CGContextMoveToPoint(context, borderRadius + strokeWidth + 0.5, round((currentFrame.size.height + HEIGHTOFPOPUPTRIANGLE) * 0.50) + 0.5)
        CGContextAddArcToPoint(context, currentFrame.size.width - strokeWidth - 0.5, round((currentFrame.size.height + HEIGHTOFPOPUPTRIANGLE) * 0.50) + 0.5, currentFrame.size.width - strokeWidth - 0.5, currentFrame.size.height - strokeWidth - 0.5, borderRadius - strokeWidth)
        CGContextAddArcToPoint(context, currentFrame.size.width - strokeWidth - 0.5, currentFrame.size.height - strokeWidth - 0.5, round(currentFrame.size.width / 2.0 + WIDTHOFPOPUPTRIANGLE / 2.0) - strokeWidth + 0.5, currentFrame.size.height - strokeWidth - 0.5, borderRadius - strokeWidth)
        CGContextAddArcToPoint(context, strokeWidth + 0.5, currentFrame.size.height - strokeWidth - 0.5, strokeWidth + 0.5, HEIGHTOFPOPUPTRIANGLE + strokeWidth + 0.5, borderRadius - strokeWidth)
        CGContextAddArcToPoint(context, strokeWidth + 0.5, round((currentFrame.size.height + HEIGHTOFPOPUPTRIANGLE) * 0.50) + 0.5, currentFrame.size.width - strokeWidth - 0.5, round((currentFrame.size.height + HEIGHTOFPOPUPTRIANGLE) * 0.50) + 0.5, borderRadius - strokeWidth)
        CGContextClosePath(context)
        CGContextClip(context)
    }

}
