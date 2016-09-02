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
  
  static func decode(_ parent: ElementType?, attributes:[String:String]?, property:AnyObject?) throws -> ElementType
  func child(_ element:ElementType)
  func parent() -> ElementType?
}


public extension ElementType {
  
  public static var element : String {
    guard let classType = self as? AnyClass else { return "" }
    let className = NSStringFromClass(classType).lowercased()
    let nameComponents = className.components(separatedBy: ".")
    return nameComponents.last!
  }
  
  
  func child(_ element:ElementType) {
    
  }
  
  
  func parent() -> ElementType? {
    return nil
  }

  
  fileprivate func encode() throws -> String {
    let result = ""
    return result
  }
}
