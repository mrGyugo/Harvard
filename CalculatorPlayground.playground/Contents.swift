//: Playground - noun: a place where people can play

import UIKit





let rect = CGRect(x: 100, y: 100, width: 100, height: 100)
let rect2 = CGRect(x: 60, y: 60, width: 50, height: 50)
var minX = rect.minX
var midX = rect.midX





let intersects = rect.intersects(rect2)

let boolka = rect.contains(CGPoint(x: 120, y: 120))


let newRect = rect2.intersection(rect)


let newView = UIView(frame: rect)
newView.alpha = 0.5

newView.isHidden = true

newView.contentMode = .redraw


newView.frame.midX

newView.contentScaleFactor



let font = UIFont.preferredFont(forTextStyle: .headline)