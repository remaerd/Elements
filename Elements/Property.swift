//
//  Property.swift
//  Elements
//
//  Created by Sean Cheng on 8/26/15.
//  Copyright © 2015 Sean Cheng. All rights reserved.
//

import Foundation


public enum PropertyError : ErrorType {
  case InvalidNSDataProperty
}


public protocol PropertyType {
  
  static func decode(string:String) throws -> PropertyType
  func encode() throws -> String
}


extension NSData : PropertyType {
  
  final public func encode() -> String {
    let options : NSDataBase64EncodingOptions = [.Encoding64CharacterLineLength]
    return self.base64EncodedStringWithOptions(options)
  }
  
  
  public static func decode(string: String) throws -> PropertyType {
    let options : NSDataBase64DecodingOptions = [.IgnoreUnknownCharacters]
    guard let data = NSData(base64EncodedString: string, options: options) else { throw PropertyError.InvalidNSDataProperty }
    return data
  }
}