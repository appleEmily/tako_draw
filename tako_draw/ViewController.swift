//
//  ViewController.swift
//  tako_draw
//
//  Created by Emily Nozaki on 2021/02/03.
//

import UIKit

class ViewController: UIViewController {
    
    //UIBezierPathっていうものがどんなものなのか調べてみよう！
    var bezierPath:UIBezierPath!
    
    var lastDrawImage:UIImage?
    
    var paperLayer: CAShapeLayer!
    
    @IBOutlet weak var paper: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = self.view.frame.width
        let height = self.view.frame.height
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchEvent = touches.first!
        let currentPoint:CGPoint = touchEvent.location(in: self.paper)
        
        //これどういうこと。
        bezierPath = UIBezierPath()
        bezierPath.lineWidth = 4.0
        bezierPath.lineCapStyle = .butt
        bezierPath.move(to:currentPoint)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if bezierPath == nil {
            return
        }
        let touchEvent = touches.first!
        let currentPoint:CGPoint = touchEvent.location(in: self.paper)
        bezierPath.addLine(to: currentPoint)
        drawLine(path: bezierPath)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if bezierPath == nil {
            return
        }
        let touchEvent = touches.first!
        let currentPoint:CGPoint = touchEvent.location(in: paper)
        bezierPath.addLine(to: currentPoint)
        drawLine(path: bezierPath)
        self.lastDrawImage = paper.image
    }
    
    func drawLine(path:UIBezierPath){
        UIGraphicsBeginImageContext(paper.frame.size)
        if let image = self.lastDrawImage {
            image.draw(at: CGPoint.zero)
        }
        let lineColor = UIColor.black
        lineColor.setStroke()
        path.stroke()
        self.paper.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    @IBAction func clear(_ sender: Any) {
        bezierPath.removeAllPoints()
        drawLine(path: bezierPath)
        self.paper.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
    
        //path を全てmoveAllPoints()
        
    }
    
    
    
    
}

