//
//  Property.swift
//  Elements
//
//  Created by Sean Cheng on 8/26/15.
//  Copyright © 2015 Sean Cheng. All rights reserved.
//

import Foundation


public extension String {
  
  var boolValue : Bool? {
    switch self {
    case "true": return true
    case "false": return false
    default: return nil
    }
  }
}