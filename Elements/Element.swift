//
//  Elements.swift
//  Elements
//
//  Created by Sean Cheng on 8/26/15.
//  Copyright © 2015 Sean Cheng. All rights reserved.
//

import Foundation


public protocol ElementType {
  
  static var element_tag    : String { get }
  static var element_rules  : [Rule]? { get }
  static var element_parent : ElementType? { get }
  
  init(parent: ElementType?, attributes:[String:String]?, property:AnyObject?) throws
  func didReceiveChildElement(element:ElementType)
}


public extension ElementType {
  
  static var element_rules  : [Rule]? { return nil }
  static var element_parent : ElementType? { return nil }
  
  private func encode() throws -> String {
    let result = ""
    return result
  }
}
