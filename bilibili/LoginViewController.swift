//
//  LoginViewController.swift
//  bilibili
//
//  Created by Sanyucz on 2017/8/30.
//  Copyright © 2017年 Sanyucz. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var inputContainer: LoginInputView!
    @IBOutlet weak var inputBottom: NSLayoutConstraint!
    @IBOutlet weak var inputBgBottom: NSLayoutConstraint!
    
    @IBOutlet weak var avatarLoginButton: UIButton!
    
    static let transitionAnimation = LoginTransitionAnimation()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.avatarLoginButton.layer.masksToBounds = true
        self.avatarLoginButton.layer.cornerRadius = 40
        
        self.inputContainer.setEditStateChangeBlock { (state) in
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {
                if state == .begin {
                    self.inputBgBottom.constant = 180
                    self.inputBottom.constant = 150
                }else {
                    self.inputBgBottom.constant = -320
                    self.inputBottom.constant = 0
                }
                self.view.setNeedsLayout()
                self.view.layoutIfNeeded()
            }, completion: { (stop) in
                UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {
                    if state == .begin {
                        self.inputBgBottom.constant = 150
                    }else {
                        self.inputBgBottom.constant = -280
                    }
                    self.view.setNeedsLayout()
                    self.view.layoutIfNeeded()
                }, completion: { (stop) in
                    
                })
            })
        }
    }
    @IBAction func closeAction(_ sender: UIButton) {
        self.view.endEditing(true)
        self.dismiss(animated: true) {
            
        }
    }
    @IBAction func loginAction(_ sender: UIButton) {
        self.transitioningDelegate = LoginViewController.transitionAnimation
        self.modalPresentationStyle = .fullScreen
        closeAction(avatarLoginButton)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let point = touches.first?.location(in: self.view)
        if (point?.y)! < CGFloat(200) {
            if self.inputContainer.editState != .end {
                self.inputContainer.editState = .end
                self.view.endEditing(true)
            }
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
