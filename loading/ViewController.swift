//
//  ViewController.swift
//  loading
//
//  Created by lumanxi on 15/9/14.
//  Copyright © 2015年 fanfan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    /*
    
    CAShapeLayer有如下一些主要属性：
    
    strokeColor：笔画颜色。
    strokeStart：笔画开始位置。
    strokeEnd：笔画结束位置。
    fillColor：图形填充颜色。
    lineWidth：笔画宽度，即笔画的粗细程度。
    lineDashPattern：虚线模式。
    path：图形的路径。
    lineCap：笔画未闭合位置的形状。
    
    */

    @IBOutlet weak var loadingView: UIView!
    let ovalShapeLayer: CAShapeLayer = CAShapeLayer()
    
    
    @IBOutlet weak var complexLoadingView: UIView!
    let anotherOvalShapeLayer: CAShapeLayer = CAShapeLayer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        ovalShapeLayer.strokeColor = UIColor.whiteColor().CGColor
        ovalShapeLayer.fillColor = UIColor.clearColor().CGColor
        ovalShapeLayer.lineWidth = 7
        let ovalRadius = loadingView.frame.size.height/2 * 0.8
        ovalShapeLayer.path = UIBezierPath(ovalInRect: CGRect(x: loadingView.frame.size.width / 2 - ovalRadius , y: loadingView.frame.size.height/2 - ovalRadius, width: ovalRadius * 2, height: ovalRadius * 2)).CGPath
        loadingView.layer.addSublayer(ovalShapeLayer)
        //ovalShapeLayer在绘制圆形时只画整个圆形的五分之二，即笔画结束的位置在整个圆形轮廓的五分之二处
        ovalShapeLayer.strokeEnd = 0.8
        //圆形轮廓两头是圆形的
        ovalShapeLayer.lineCap = kCALineCapRound
        

        
        
        anotherOvalShapeLayer.strokeColor = UIColor.whiteColor().CGColor
        anotherOvalShapeLayer.fillColor = UIColor.clearColor().CGColor
        anotherOvalShapeLayer.lineWidth = 7
        
        let anotherOvalRadius = complexLoadingView.frame.size.height/2 * 0.8
        anotherOvalShapeLayer.path = UIBezierPath(ovalInRect: CGRect(x: complexLoadingView.frame.size.width/2 - anotherOvalRadius, y: complexLoadingView.frame.size.height/2 - anotherOvalRadius, width: anotherOvalRadius * 2, height: anotherOvalRadius * 2)).CGPath
        anotherOvalShapeLayer.lineCap = kCALineCapRound
        
        complexLoadingView.layer.addSublayer(anotherOvalShapeLayer)
    }

    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    
        self.ovalShapeLayer.strokeEnd = CGFloat.init(drand48())
    }
    
    
    /*
    
    CAPropertyAnimation实例。常用的keyPath有如下一些：
    
    transform.rotation：旋转动画。
    transform.ratation.x：按x轴旋转动画。
    transform.ratation.y：按y轴旋转动画。
    transform.ratation.z：按z轴旋转动画。
    transform.scale：按比例放大缩小动画。
    transform.scale.x：在x轴按比例放大缩小动画。
    transform.scale.y：在y轴按比例放大缩小动画。
    transform.scale.z：在z轴按比例放大缩小动画。
    position：移动位置动画。
    opacity：透明度动画。
    duration：动画持续时间。
    fromValue：动画起始值。
    toValue：动画结束值。
    repeatCount：重复次数。
    
    */
    func beginSimpleAnimation() {
        let rotate = CABasicAnimation(keyPath: "transform.rotation")
        rotate.duration = 1.5
        rotate.fromValue = 0
        rotate.toValue = 2 * M_PI
        rotate.repeatCount = HUGE
        loadingView.layer.addAnimation(rotate, forKey: nil)
    }
    
    func beginComplexAnimation(){
        let strokeStartAnimate = CABasicAnimation(keyPath: "strokeStart")
        strokeStartAnimate.fromValue = -0.5
        strokeStartAnimate.toValue = 1
        
        let strokeEndAnimate = CABasicAnimation(keyPath: "strokeEnd")
        strokeEndAnimate.fromValue = 0.0
        strokeEndAnimate.toValue = 1
        
        let strokeAnimateGroup = CAAnimationGroup()
        strokeAnimateGroup.duration = 1.5
        strokeAnimateGroup.repeatCount = HUGE
        strokeAnimateGroup.animations = [strokeStartAnimate, strokeEndAnimate]
        anotherOvalShapeLayer.addAnimation(strokeAnimateGroup, forKey: nil)
    }
    
    

    override func viewWillAppear(animated: Bool) {
        beginSimpleAnimation()
        beginComplexAnimation()
    }
    
    func endSimpleAnimation(){
        loadingView.layer.removeAllAnimations()
        complexLoadingView.layer.removeAllAnimations()
    }
    override func viewWillDisappear(animated: Bool) {
        endSimpleAnimation()
    }

}

