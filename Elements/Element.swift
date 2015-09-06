//
//  Elements.swift
//  Elements
//
//  Created by Sean Cheng on 8/26/15.
//  Copyright © 2015 Sean Cheng. All rights reserved.
//

import Foundation


public protocol ElementType {
  
  static var element : String { get }
  
  static func decode(parent: ElementType?, attributes:[String:String]?, property:AnyObject?) throws -> ElementType
  func child(element:ElementType)
  func parent() -> ElementType?
}


public extension ElementType {
  
  public static var element : String {
    guard let classType = self as? AnyClass else { return "" }
    let className = NSStringFromClass(classType).lowercaseString
    let nameComponents = className.componentsSeparatedByString(".")
    return nameComponents.last!
  }
  
  
  func child(element:ElementType) {
    
  }
  
  
  func parent() -> ElementType? {
    return nil
  }

  
  private func encode() throws -> String {
    let result = ""
    return result
  }
}
