//
//  Rule.swift
//  Elements
//
//  Created by Sean Cheng on 8/26/15.
//  Copyright © 2015 Sean Cheng. All rights reserved.
//

import Foundation


public enum RuleType {
  
  case NilProperty
  case RequiredProperty(type:AnyClass?)
  
  case RequiredAttribute(attributeName:String, type:PropertyType?, propertyName: String?)
  
  case RequiredZeroOrOneChildElement(elementType:ElementType)
  case RequiredOneOrMoreChildElement(elementType:ElementType)
  case RequiredZeroOrMoreChildElement(elementType:ElementType)
}


public struct Rule {
  
  var tag   : String
  var type  : RuleType
  
  func validate(element:ElementType) {
    
  }
}