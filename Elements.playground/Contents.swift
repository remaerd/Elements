//: Playground - noun: a place where people can play

import Cocoa
import Elements


class Root : ElementType {
  
  static var tag  : String { return "root" }
  var parent      : ElementType?
}


var xmlString = "<root version=\"1.0\"><tags><tag/><tag>Hello World<tag><tags></xml>"
var xml = try XML(xml: xmlString)
try xml.detectElementTypeWithClass(Root.self)
xml.decode { (error) -> Void in
  print(error)
}
