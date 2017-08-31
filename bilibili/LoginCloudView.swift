//
//  LoginCloudView.swift
//  bilibili
//
//  Created by Sanyucz on 2017/8/30.
//  Copyright © 2017年 Sanyucz. All rights reserved.
//

import UIKit

class LoginCloudView: UIView {

    let scroll = UIScrollView()
    var timer:Timer?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        func getCloudView(x:CGFloat) -> CloudView {
            var frame = bounds
            frame.origin.x = x
            let view = CloudView(frame: frame)
            view.backgroundColor = UIColor.clear
            return view
        }
        scroll.frame = bounds
        scroll.addSubview(getCloudView(x: 0))
        scroll.addSubview(getCloudView(x: bounds.size.width))
        scroll.contentSize = CGSize(width: bounds.size.width*2, height: bounds.size.height)
        scroll.backgroundColor = UIColor.clear
        scroll.isScrollEnabled = false
        addSubview(scroll)
        Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { (timer) in
            var offset = self.scroll.contentOffset
            offset.x += 0.5
            if (offset.x >= self.bounds.size.width) {
                offset.x = 0
            }
            self.scroll.contentOffset = offset
        }
    }

}


class CloudView: UIView {
    let centerXs:[CGFloat] = [30, 100, 160, 220, 280, 345]
    let centerYs:[CGFloat] = [0, 4, 6, 10, 5, 0]
    
    override func draw(_ rect: CGRect) {
        
        let color = UIColor.white
        color.set() // 设置线条颜色
        
        let path = UIBezierPath()
        for centerX in centerXs.enumerated() {
            path.addArc(withCenter: CGPoint(x:centerX.element, y:80-centerYs[centerX.offset]), radius: 40,
                        startAngle: CGFloat(Double.pi), endAngle: 0, clockwise: true)
        }
        path.lineWidth = 1.0
        path.fill()
    }
}
