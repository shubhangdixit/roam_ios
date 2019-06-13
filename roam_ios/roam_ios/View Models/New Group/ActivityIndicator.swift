//
//  ActivityIndicator.swift
//  roam_ios
//
//  Created by Shubhang Dixit on 13/06/19.
//  Copyright © 2019 Shubhang Dixit. All rights reserved.
//

import Foundation
import UIKit

class ActivityIndicator: UIView {
    
    @IBOutlet weak var spinnerImageView: UIImageView!
    
    override init (frame : CGRect)  {
        super.init(frame: frame)
        setup()
    }
    
    class func instantiateView() -> ActivityIndicator {
        return Bundle.main.loadNibNamed("ActivityIndicator", owner: nil, options: nil)?[0] as! ActivityIndicator
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    func setup() {
        dimBackGround(withAlpha: 0)
        self.layer.zPosition = 1
        self.frame = UIScreen.main.bounds
        let width = 80
        let height = 80
        let testFrame : CGRect = CGRect(x:0 , y:0 , width: width, height: height)
        let backGroundView : UIView = UIView(frame: testFrame)
        backGroundView.center = self.center
        self.addSubview(backGroundView)
        backGroundView.layer.cornerRadius = 10
        self.sendSubviewToBack(backGroundView)
        
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        visualEffectView.frame = backGroundView.bounds
        backGroundView.addSubview(visualEffectView)
        visualEffectView.layer.cornerRadius = 10
        visualEffectView.alpha = 1
        visualEffectView.clipsToBounds = true
        
        self.frame = bounds
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.translatesAutoresizingMaskIntoConstraints = true
        self.isHidden = true
        
    }
    
    func dimBackGround(withAlpha : CGFloat) {
        backgroundColor = UIColor.black.withAlphaComponent(withAlpha)
        
    }
    
    
    func startSpinner(){
        self.isHidden = false
        
        self.spinnerImageView.isHidden = false
        
        self.spinnerImageView.alpha = 0.30
        UIView.animate(withDuration: 5, delay: 0.2, options: [.curveEaseIn],
                       animations: {
                        
                        
                        self.spinnerImageView.alpha = 0.9
        },  completion: nil )
        
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        
        let radians = CGFloat.pi
        rotateAnimation.fromValue = radians
        rotateAnimation.toValue = radians + .pi + .pi
        rotateAnimation.isRemovedOnCompletion = false
        rotateAnimation.duration = CFTimeInterval (0.8)
        rotateAnimation.repeatCount=Float.infinity
        spinnerImageView.layer.add(rotateAnimation, forKey: nil)
        
    }
    
    func stopSpinner(delay : TimeInterval = 0.4) {
        self.isHidden = false
        self.spinnerImageView.isHidden = false
        
        UIView.animate(withDuration: 0.6, delay: 0, options: [.curveEaseIn],
                       animations: {
                        
                        self.spinnerImageView.alpha = 0
                        
        },  completion: {(_ finished: Bool) -> Void in
            UIView.animate(withDuration: 0.5, delay: delay, options: [.curveEaseIn],
                           animations: {
                            
                            self.isHidden = true
                            
            },  completion: nil )
        } )
    }
    
    func hideSpinner(delay : TimeInterval = 0.1) {
        UIView.animate(withDuration: 0.3, delay: delay, options: [.curveEaseIn],
                       animations: {
                        
                        self.isHidden = true
                        
        },  completion: nil )
        
    }
    
    
}
