//
//  Categories.swift
//  smallday_test
//
//  Created by zzl on 2016/11/4.
//  Copyright © 2016年 Zhou. All rights reserved.
//

import Foundation
import UIKit
import YYCategories
import ReactiveCocoa
/*******颜色*******/
//RGB转换
func RGB(r:CGFloat, g:CGFloat, b:CGFloat) ->UIColor {
    return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
}

//设置屏幕尺寸
public let kScreenWidth = UIScreen.main.bounds.size.width
public let kScreenHeight = UIScreen.main.bounds.size.height

func kURL(url: String) -> URL {
    return URL.init(string: url)!
}



/*
extension UIView {
    var width: CGFloat {
        get {
            return self.frame.width
        }
        set(newValue) {
            var newFrame = self.frame
            newFrame.size.width = newValue
            self.frame = newFrame
        }
    }
    var height: CGFloat {
        get {
            return self.frame.height
        }
        set(newValue) {
            var newFrame = self.frame
            newFrame.size.height = newValue
            self.frame = newFrame
        }
    }
    var top: CGFloat {
        get {
            return self.frame.midY
        }
        set(newValue) {
            var newFrame = self.frame
            newFrame.origin.y = newValue
            self.frame = newFrame
        }
    }
    var right: CGFloat {
        get {
            return self.frame.maxX
        }
        set(newValue) {
            let delta = newValue - (self.frame.origin.x + self.frame.size.width)
            var newframe = self.frame
            newframe.origin.x += delta
            self.frame = newframe
        }
    }
    var bottom: CGFloat {
        get {
            return self.frame.maxY
        }
        set(newValue) {
            var newframe = self.frame
            newframe.origin.y = newValue - self.frame.size.height
            self.frame = newframe
        }
    }
    var left: CGFloat {
        get {
            return self.frame.minX
        }
        set(newValue) {
            var newframe = self.frame
            newframe.origin.x = newValue
            self.frame = newframe
        }
    }
    
}

//获取视图尺寸
public func x(view: UIView) -> CGFloat {
    return view.frame.origin.x;
}
public func y(view: UIView) -> CGFloat {
    return view.frame.origin.y;
}
public func width(view: UIView) ->CGFloat {
    return view.frame.size.width
}
public func height(view: UIView) ->CGFloat {
    return view.frame.size.height
}
public func bottom(view: UIView) ->CGFloat {
    return view.frame.origin.y + view.frame.size.height
}

*/













