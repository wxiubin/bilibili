//
//  ViewController.swift
//  bilibili
//
//  Created by Sanyucz on 2017/8/29.
//  Copyright © 2017年 Sanyucz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func loginAction(_ sender: UIButton) {
        
        let vc = LoginViewController(nibName: "LoginViewController", bundle: nil)
        
        vc.transitioningDelegate = LoginViewController.transitionAnimation
        vc.modalPresentationStyle = .fullScreen
        self.tabBarController?.present(vc, animated: true, completion: {
            
        })
    }
    
    @IBAction func addRotateAction(_ sender: UIButton) {
        self.definesPresentationContext = true
        let vc = AddRotateAnimationController(nibName: "AddRotateAnimationController", bundle: nil)
        vc.modalPresentationStyle = .overCurrentContext
        self.tabBarController?.present(vc, animated: false, completion: {
            
        })
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

