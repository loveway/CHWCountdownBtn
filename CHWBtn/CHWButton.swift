//
//  CHWButton.swift
//  CHWBtn
//
//  Created by Loveway on 15/7/22.
//  Copyright (c) 2015年 Henry·Cheng. All rights reserved.
//

import UIKit
enum CountBtnType {
    case CHWBtnTypeScale
    case CHWBtnTypeRotate
}

class CHWButton: UIButton {
    // 正常的颜色
    private var normal_bgColor = UIColor(red: CGFloat(237 / 255.0), green: CGFloat(85 / 255.0), blue: CGFloat(101 / 255.0), alpha: 1)
    // 倒计时中的颜色
    var enabled_bgColor = UIColor.lightGray
    private var timer: Timer!
    private var startCount = 0
    private var originNum = 0
    //倒计时Label
    private var timeLabel = UILabel()
    var animaType = CountBtnType.CHWBtnTypeScale
    
    convenience init(count: Int,frame: CGRect , color: UIColor?) {
        var color = color
        self.init(frame: frame)
        self.setTitleColor(UIColor.white, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        //如果设定的有colo就显示color，没有就显示默认的
        if color == nil {
            color = normal_bgColor
        } else {
            normal_bgColor = color!
        }
        self.backgroundColor = color
        self.startCount = count
        self.originNum = count
        self.addLabel()
        super.addTarget(self, action: #selector(startCountDown), for: .touchUpInside )
    }
    
//    倒计时的Label
    func addLabel() {
        timeLabel.frame = CGRect(x: 0,y: 0,width: self.frame.width,height: self.frame.height)
        timeLabel.backgroundColor = UIColor.clear
        timeLabel.font = UIFont.systemFont(ofSize: 17.0)
        timeLabel.textAlignment = NSTextAlignment.center
        timeLabel.text = "\(self.originNum)"
        self.addSubview(timeLabel)
        
    }

//    开启定时器
    @objc func startCountDown() {
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        self.backgroundColor = enabled_bgColor
//        self.setTitleColor(UIColor.blackColor(), forState: UIControlState.Disabled)
        self.isEnabled = false
        
        //动画开始
        switch self.animaType {
        case .CHWBtnTypeScale :
            self.numAnimation()
        case .CHWBtnTypeRotate:
            self.rotateAnimation()
        }

        print("pass")
    }
    
//    倒计时开始
    @objc func countDown() {
        self.startCount -= 1
        timeLabel.text = "\(self.startCount)"
        
       //倒计时完成后停止定时器，移除动画
        if self.startCount < 0 {
            if self.timer == nil {
                return
            }
            timeLabel.layer.removeAllAnimations()
            timeLabel.text = "\(self.originNum)"
            self.timer.invalidate()
            self.timer = nil
            self.isEnabled = true
            self.startCount = self.originNum
            self.backgroundColor = normal_bgColor
        }
        
    }
    
//    放大动画
    func numAnimation() {
        let duration: CFTimeInterval = 1
        let beginTime = CACurrentMediaTime()
        
        // Scale animation
        let scaleAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        
        scaleAnimation.keyTimes = [0, 0.5, 1]
        scaleAnimation.values = [1, 1.5, 2]
        scaleAnimation.duration = duration
        
        // Opacity animation
        let opacityAnimaton = CAKeyframeAnimation(keyPath: "opacity")
        
        opacityAnimaton.keyTimes = [0, 0.5, 1]
        opacityAnimaton.values = [1, 0.5, 0]
        opacityAnimaton.duration = duration
        
        // Animation
        let animation = CAAnimationGroup()
        
        animation.animations = [scaleAnimation, opacityAnimaton]
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = duration
        animation.repeatCount = HUGE
        animation.isRemovedOnCompletion = false

        animation.beginTime = beginTime
        timeLabel.layer.add(animation, forKey: "animation")
        self.layer.addSublayer(timeLabel.layer)

    }
    
//    旋转变小动画
    func rotateAnimation() {
        
        let duration: CFTimeInterval = 1
        let beginTime = CACurrentMediaTime()

        // Rotate animation
        let rotateAnimation  = CABasicAnimation(keyPath: "transform.rotation.z")
        rotateAnimation.fromValue = NSNumber(value: 0)
        rotateAnimation.toValue = NSNumber(value: Double.pi * 2)
        rotateAnimation.duration = duration;
        
        // Scale animation
        let scaleAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        scaleAnimation.keyTimes = [0]
        scaleAnimation.values = [1, 2]
        scaleAnimation.duration = 0
        
        // Opacity animation
        let opacityAnimaton = CAKeyframeAnimation(keyPath: "opacity")
        opacityAnimaton.keyTimes = [0, 0.5]
        opacityAnimaton.values = [1, 0]
        opacityAnimaton.duration = duration
        
        // Scale animation
        let scaleAnimation2 = CAKeyframeAnimation(keyPath: "transform.scale")
        scaleAnimation2.keyTimes = [0, 0.5]
        scaleAnimation2.values = [2, 0]
        scaleAnimation2.duration = duration
        
        let animation = CAAnimationGroup()
        
        animation.animations = [rotateAnimation, scaleAnimation, opacityAnimaton, scaleAnimation2]
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = duration
        animation.repeatCount = HUGE
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false
        animation.beginTime = beginTime
        timeLabel.layer.add(animation, forKey: "animation")
        self.layer.addSublayer(timeLabel.layer)
        
//        let shakeAnimation = CABasicAnimation(keyPath: "transform.translation.x")
//        
//        shakeAnimation.duration = 0.08;
//        shakeAnimation.fromValue = NSNumber(int: -5)
//        shakeAnimation.toValue = NSNumber(int: 5)
//        shakeAnimation.repeatCount = 4
//        shakeAnimation.autoreverses = YES;
//        timeLabel.layer.addAnimation(shakeAnimation, forKey: nil)
//        self.layer.addSublayer(timeLabel.layer)

    }

}
