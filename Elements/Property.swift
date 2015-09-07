//
//  Property.swift
//  Elements
//
//  Created by Sean Cheng on 8/26/15.
//  Copyright © 2015 Sean Cheng. All rights reserved.
//

import Foundation


public extension Bool {
  
  public init?(_ string:String) {
    self.init()
    if string == "true" { self = true }
    else if string == "false" { self = false }
    return nil
  }
}