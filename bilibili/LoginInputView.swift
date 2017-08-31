//
//  LoginInputView.swift
//  bilibili
//
//  Created by Sanyucz on 2017/8/30.
//  Copyright © 2017年 Sanyucz. All rights reserved.
//

import UIKit

enum ViewTag: Int {
    case userBtn = 1
    case pswdBtn = 3
    case userTf = 2
    case pswdTf = 4
    case loginBtn = 5
}

class LoginInputView: UIView {
    
    enum EditState {
        case begin, end
    }
    typealias EditStateChange = (_ state: EditState)->()
    var editStateChangeBlock:EditStateChange?
    var editState:EditState = .end {
        didSet {
            self.editStateChangeBlock?(editState)
        }
    }
    public func setEditStateChangeBlock(_ block:@escaping EditStateChange) {
        self.editStateChangeBlock = block
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let loginBtn = viewWithTag(ViewTag.loginBtn.rawValue)
        loginBtn?.layer.masksToBounds = true
        loginBtn?.layer.cornerRadius = 10
        loginBtn?.backgroundColor = UIColor.init(white: 1, alpha: 0.8)
    }
    
    func isEdit() -> Bool {
        let tf1 = viewWithTag(ViewTag.userTf.rawValue) as! UITextField
        let tf2 = viewWithTag(ViewTag.pswdTf.rawValue) as! UITextField
        return tf1.isEditing || tf2.isEditing
    }
    
    override func draw(_ rect: CGRect) {
 
    }

    func getBtn(textField tf: UITextField) -> UIButton? {
        var btn: UIButton?
        if viewWithTag(ViewTag.userTf.rawValue) == tf {
            btn = viewWithTag(ViewTag.userBtn.rawValue) as? UIButton
        } else if viewWithTag(ViewTag.pswdTf.rawValue) == tf {
            btn = viewWithTag(ViewTag.pswdBtn.rawValue) as? UIButton
        }
        return btn
    }
}

extension LoginInputView: UITextFieldDelegate {
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if isEdit() == false {
            self.editState = .begin
        }
        getBtn(textField: textField)?.isSelected = true
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        let btn = getBtn(textField: textField)
        btn?.isSelected = false
        return true
    }
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if viewWithTag(ViewTag.userTf.rawValue) == textField {
            viewWithTag(ViewTag.pswdTf.rawValue)?.becomeFirstResponder()
        }
        return false
    }
}
