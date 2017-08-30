//
//  AddRotateAnimationController.swift
//  bilibili
//
//  Created by Sanyucz on 2017/8/30.
//  Copyright © 2017年 Sanyucz. All rights reserved.
//

import UIKit

class AddRotateAnimationController: UIViewController, CAAnimationDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.init(white: 0.2, alpha: 0.5)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.viewWithTag(1)?.isHidden = true
        view.viewWithTag(2)?.isHidden = true
        view.viewWithTag(3)?.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        func arcAnimation(view: UIView, path:UIBezierPath) {
            let animation = CAKeyframeAnimation(keyPath: "position")
            animation.delegate = self
            animation.duration = 0.35
            animation.path = path.cgPath
            animation.isRemovedOnCompletion = false
            animation.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)]
            view.isHidden = false
            view.layer.add(animation, forKey: "animation")
        }
        
        let bounds = UIScreen.main.bounds
        let center = CGPoint(x: bounds.width - 60, y: bounds.height - 100)
        
        let path1 = UIBezierPath()
        path1.addArc(withCenter: center, radius: 140, startAngle: CGFloat(Double.pi*3/4), endAngle: CGFloat(Double.pi*3/2), clockwise: true)
        let path2 = UIBezierPath()
        path2.addArc(withCenter: center, radius: 140, startAngle: CGFloat(Double.pi*3/4), endAngle: CGFloat(Double.pi*5/4), clockwise: true)
        let path3 = UIBezierPath()
        path3.addArc(withCenter: center, radius: 140, startAngle: CGFloat(Double.pi*3/4), endAngle: CGFloat(Double.pi), clockwise: true)
        
        arcAnimation(view: view.viewWithTag(1)!, path: path1)
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
            arcAnimation(view: self.view.viewWithTag(2)!, path: path2)
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+0.2) {
            arcAnimation(view: self.view.viewWithTag(3)!, path: path3)
        }
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
    }
    
    @IBAction func closeAction(_ sender: UIButton) {
        hidden()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        hidden()
    }
    
    func hidden() -> Void {
        
        
        func dismissAnimation(view:UIView, start:CGFloat) {
            
            let bounds = UIScreen.main.bounds
            let center = CGPoint(x: bounds.width - 60, y: bounds.height - 100)
            let path = UIBezierPath()
            path.addArc(withCenter: center, radius: 140, startAngle: start, endAngle: start+CGFloat(Double.pi), clockwise: true)
            let animation = CAKeyframeAnimation(keyPath: "position")
            animation.delegate = self
            animation.duration = 0.35
            animation.path = path.cgPath
            animation.isRemovedOnCompletion = false
            animation.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)]
            view.isHidden = false
            view.layer.add(animation, forKey: "animation")
        }
        dismissAnimation(view: view.viewWithTag(1)!, start: CGFloat(Double.pi*3/2))
        dismissAnimation(view: view.viewWithTag(2)!, start: CGFloat(Double.pi*5/4))
        dismissAnimation(view: view.viewWithTag(3)!, start: CGFloat(Double.pi))
        DispatchQueue.main.asyncAfter(deadline: .now()+0.2) {
            self.dismiss(animated: false) { }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
