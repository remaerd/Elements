//: Playground - noun: a place where people can play

import Cocoa
import Elements


var xml = "<xml version=\"1.0\"><tags><tag/><tag>Hello World<tag><tags></xml>"

public func detectElementTypeWithClass(classType:AnyClass?) throws {
  guard let element = classType as? ElementType.Type else { return }
  element.tag
}


class Root : ElementType {
  
  static let tag = "Root"
  
  
  let version : String = ""
}


try? detectElementTypeWithClass(Root.self)



//
//
//struct Tag : ElementType {
//  let content : String
//}
//
//
//let root = XML()