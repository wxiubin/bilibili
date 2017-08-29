//
//  TabbarController.swift
//  bilibili
//
//  Created by Sanyucz on 2017/8/29.
//  Copyright © 2017年 Sanyucz. All rights reserved.
//

import UIKit

class TabbarController: UITabBarController {

    let myTabbar = Tabbar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupChilVC()
        setupTabbar()
    }

    func setupChilVC() -> Void {
        
        for title in ["home","explore","communicate","mine"] {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! UINavigationController
            vc.viewControllers.first?.navigationItem.title = title
            self.addChildViewController(vc)
        }
        
    }
    
    
    func setupTabbar() -> Void {
        
        func createBtn(img:UIImage, selectImg:UIImage, tag:Int) -> UIButton {
            let btn = UIButton()
            btn.setImage(img, for: .normal)
            btn.setImage(selectImg, for: .selected)
            btn.setImage(selectImg, for: [.selected, .highlighted])
            btn.adjustsImageWhenHighlighted = false
            btn.tag = tag
            btn.addTarget(self, action: #selector(buttonDidClick(_:)), for: .touchUpInside)
            return btn
        }
        
        var buttons:[UIButton] = [UIButton]()
        buttons.append(createBtn(img: #imageLiteral(resourceName: "tab_home_normal"), selectImg: #imageLiteral(resourceName: "tab_home_select"), tag: 0))
        buttons.append(createBtn(img: #imageLiteral(resourceName: "tab_explore_normal"), selectImg: #imageLiteral(resourceName: "tab_explore_select"), tag: 1))
        buttons.append(createBtn(img: #imageLiteral(resourceName: "tab_add_normal"), selectImg: #imageLiteral(resourceName: "tab_add_select"), tag: 4))
        buttons.append(createBtn(img: #imageLiteral(resourceName: "tab_communicate_normal"), selectImg: #imageLiteral(resourceName: "tab_communicate_select"), tag: 2))
        buttons.append(createBtn(img: #imageLiteral(resourceName: "tab_mine_normal"), selectImg: #imageLiteral(resourceName: "tab_mine_select"), tag: 3))
        
        myTabbar.shadowImage = UIImage()
        myTabbar.backgroundImage = UIImage()
        myTabbar.backgroundColor = UIColor.white
        myTabbar.addButtons(buttons)
        self.buttonDidClick(buttons.first!)
        self.setValue(myTabbar, forKeyPath: "tabBar")
    }
    
    @objc func buttonDidClick(_ btn:UIButton) -> Void {
        
        if btn.tag < 4 {
            for button in myTabbar.buttons! {
                button.isSelected = false
            }
            btn.isSelected = true
            self.selectedIndex = btn.tag
            
            let transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            UIView.animate(withDuration: 0.15, animations: {
                btn.imageView?.transform = transform
            }, completion: { (stop) in
                btn.imageView?.transform = .identity
            })
        }else {
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


class Tabbar: UITabBar {
    
    var buttons:[UIButton]?
    
    func addButtons(_ buttons:[UIButton]) -> Void {
        self.buttons = buttons
        for btn in buttons {
            self.addSubview(btn)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        for sub in self.subviews {
            if type(of: sub) == NSClassFromString("UITabBarButton") {
                sub.isHidden = true
            }
        }
        
        if buttons == nil { return }
        
        let w: CGFloat = bounds.size.width / CGFloat((buttons?.count)!)
        let h: CGFloat = bounds.size.height
        
        for e in (buttons?.enumerated())! {
            if e.offset == 2 {
                e.element.frame = CGRect(x: w * CGFloat(e.offset), y: -10, width: w, height: h+10)
            }else {
                e.element.frame = CGRect(x: w * CGFloat(e.offset), y: 0, width: w, height: h)
            }
        }
    }
    
}
