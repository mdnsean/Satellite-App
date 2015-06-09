//
//  ViewController.swift
//  Satellite
//
//  Created by Honza on 02/06/15.
//  Copyright (c) 2015 Sean. All rights reserved.
//

import UIKit
import SpriteKit


class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var earth: UIImageView!
    @IBOutlet weak var speed: UITextField!
    @IBOutlet weak var elevation: UITextField!
    @IBOutlet weak var satellite: UIImageView!
    @IBOutlet weak var errorBox: UILabel!

    @IBAction func configure(sender: AnyObject) {
        if elevation.text != "" && speed.text != "" {
            var el = elevation.text.toInt()!
            var sp = speed.text.toInt()!
            if el < 10 || el > 50 {
                errorBox.text = "Please enter a valid elevation (10 to 50 miles)"
            } else if sp < 100 || sp > 1000 {
                errorBox.text = "Please enter a valid speed (100 to 1000 mph)"
            } else {
                errorBox.text = ""
                var path = UIBezierPath(arcCenter: earth.center, radius: CGFloat(80) + CGFloat(el), startAngle: CGFloat(0), endAngle: CGFloat(360), clockwise: true)
                
                let anim = CAKeyframeAnimation(keyPath: "position")
                
                anim.path = path.CGPath
                anim.rotationMode = kCAAnimationRotateAuto
                anim.repeatCount = Float.infinity
                anim.duration = 2500.0 * (80.0 + Double(el)) / Double(sp)
                
                satellite.layer.addAnimation(anim, forKey: "animate")
            }
        }
    }
    override func viewDidLayoutSubviews() {
        
        satellite.center = CGPointMake(satellite.center.x - 400, satellite.center.y)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
        self.speed.delegate = self
        self.elevation.delegate = self
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func DismissKeyboard(){
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

