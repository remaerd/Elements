//
//  Property.swift
//  Elements
//
//  Created by Sean Cheng on 8/26/15.
//  Copyright © 2015 Sean Cheng. All rights reserved.
//

import Foundation


public extension String {
  
  public func boolValue() -> Bool? {
    switch self {
    case "true": return true
    case "false": return false
    default: return nil
    }
  }
  
  
  public func boolValue(_ defaultValue:Bool) -> Bool {
    switch self {
    case "true": return true
    case "false": return false
    default: return defaultValue
    }
  }
}
