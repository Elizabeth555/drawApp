//
//  SecondViewController.swift
//  drawApp
//
//  Created by Rosie Gollancz on 06/12/2016.
//  Copyright © 2016 RAKE. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet var drawPage: UIImageView!
    //change to imageView
   
    var lastPoint = CGPoint.zero
    var moved = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        moved = false
        
        if let touch = touches.first {
           lastPoint = touch.location(in: self.view)
        }
    }
    
    func drawPicture(fromPoint:CGPoint, toPoint:CGPoint) {
        UIGraphicsBeginImageContextWithOptions(self.view.frame.size, false, 0.0)
        drawPage.image?.draw(in: CGRect(x: 0, y:0, width:self.view.frame.width, height:self.view.frame.height))
        let context = UIGraphicsGetCurrentContext()
        
        context?.move(to: CGPoint(x: fromPoint.x, y: fromPoint.y))
        context?.addLine(to: CGPoint(x: toPoint.x, y: toPoint.y))
        
        context?.setBlendMode(CGBlendMode.color)
        context?.setLineCap(CGLineCap.round)
        context?.setLineWidth(5)
        context?.setStrokeColor(UIColor(red: 0.26, green: 0.53, blue: 0.96, alpha: 1.0).cgColor)
        
        context?.strokePath()
        
        drawPage.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
    }
    
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        moved = true
        
        if let touch = touches.first {
            let currentPoint = touch.location(in: self.view)
            drawPicture(fromPoint: lastPoint, toPoint: currentPoint)
            
            lastPoint = currentPoint
            
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !moved {
            drawPicture(fromPoint: lastPoint, toPoint: lastPoint)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

