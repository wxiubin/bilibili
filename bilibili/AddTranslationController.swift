//
//  AddViewController.swift
//  bilibili
//
//  Created by Sanyucz on 2017/8/29.
//  Copyright © 2017年 Sanyucz. All rights reserved.
//

import UIKit

class AddTranslationController: UIViewController {

    typealias AddVCBlock = (_ index: Int)->()
    var actionBlock:AddVCBlock?
    
    @IBOutlet weak var closeBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let blurEffect = UIBlurEffect(style: .light);
        let visualView = UIVisualEffectView(effect: blurEffect);
        visualView.frame = view.bounds
        
        view.addSubview(visualView)
        view.sendSubview(toBack: visualView)
    }
    func setActionBlock(_ action:@escaping AddVCBlock) { self.actionBlock = action}
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        func prepareShow(view:UIView) {
            view.alpha = 0
            view.transform = CGAffineTransform(translationX: 0, y: 30)
        }
        prepareShow(view: view.viewWithTag(1)!)
        prepareShow(view: view.viewWithTag(2)!)
        prepareShow(view: view.viewWithTag(3)!)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        func beginShowAnimation(view: UIView, delay:TimeInterval = 0) {
            UIView.animate(withDuration: 0.2, delay: delay, options: .curveEaseIn, animations: {
                view.alpha = 1
                view.transform = .identity
            }) { (stop) in
                
            }
        }
        beginShowAnimation(view: self.view.viewWithTag(1)!, delay: 0.15)
        beginShowAnimation(view: self.view.viewWithTag(2)!, delay: 0.25)
        beginShowAnimation(view: self.view.viewWithTag(3)!, delay: 0.35)
        
    }
    
    
    
    @IBAction func activeAction(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
            sender.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            sender.alpha = 0.1
        }) { (stop) in
            self.hidden(index: sender.tag)
        }
    }
    @IBAction func closeAction(_ sender: UIButton) {
        
        func beginShowAnimation(view: UIView, delay:TimeInterval = 0) {
            UIView.animate(withDuration: 0.2, delay: delay, options: .curveEaseIn, animations: {
                view.alpha = 0
                view.transform = CGAffineTransform(translationX: 0, y: -30)
            }) { (stop) in
                
            }
        }
        beginShowAnimation(view: self.view.viewWithTag(1)!, delay: 0.0)
        beginShowAnimation(view: self.view.viewWithTag(2)!, delay: 0.1)
        beginShowAnimation(view: self.view.viewWithTag(3)!, delay: 0.2)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.hidden(index: sender.tag)
        }
    }
    
    func hidden(index: Int) -> Void {
        UIView.animate(withDuration: 0.2, animations: {
            self.view.alpha = 0
        }) { (stop) in
            self.dismiss(animated: false) {
                self.actionBlock?(index)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
