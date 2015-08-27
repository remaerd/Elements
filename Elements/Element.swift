//
//  Elements.swift
//  Elements
//
//  Created by Sean Cheng on 8/26/15.
//  Copyright © 2015 Sean Cheng. All rights reserved.
//

import Foundation


public protocol ElementType {
  
  static var tag    : String { get }
  static var rules  : [Rule]? { get }
  
//  var parent      : ElementType { get }
//  var children    : [String:ElementType]?  { get }
//  var property    : PropertyType?  { get }
//  var attributes  : [String:PropertyType]?  { get }
  
  init(property:String?, attributes:[String:String])
  func shouldAppendElement(element:ElementType)
}


public extension ElementType {
  
//  Due to Swift 2.0 issue. The framework is not buildable if these code exist. So I comment them and wait it'll work with new version of Swift.
  
//  public static var tag : String {
//    if let classType = self as? AnyClass { NSStringFromClass(classType.dynamicType) }
//    return ""
//  }
  
  
  public static var rules : [Rule]? {
    return nil
  }
  
  
  func appendElement(element:ElementType) throws {
    
  }
  
  
  private func encode() throws -> String {
    let result = ""
    return result
  }
}
