//
//  Tests.swift
//  Tests
//
//  Created by Sean Cheng on 9/2/15.
//  Copyright © 2015 Sean Cheng. All rights reserved.
//

import XCTest
import Elements


class Element : ElementType {
  
  enum Error : ErrorType {
    case InvalidMessage
  }
  
  
  static var element_tag = "element"
  
  let message : String!
  let xml     : XML!
  
  var element_parent : XML {
    return xml
  }
  
  required init(parent: ElementType?, attributes: [String : String]?, property: AnyObject?) throws {
    self.message = property as? String
    self.xml = parent as? XML
    if self.message == nil && self.xml == nil { throw Error.InvalidMessage }
  }
  
  
  func didReceiveChildElement(element: ElementType) {
    
  }
}


class XML : ElementType {
  
  static var element_tag = "xml"
  
  var children : [Element]
  
  required init(parent: ElementType?, attributes: [String : String]?, property: AnyObject?) throws {
    self.children = [Element]()
  }
  
  
  func didReceiveChildElement(element: ElementType) {
    if let child = element as? Element { self.children.append(child) }
  }
}



class Tests: XCTestCase {
  
  func testDefineElementType() {
    print(XML.element_tag)
    XCTAssertTrue(XML.element_tag == "xml")
  }
  
  
  func testDecode() {
    
    let xmlString = "<xml><element>Hello World</element></xml>"
    do {
      let xml = try Elements.XML(xml: xmlString)
      try xml.detectElementTypeWithClass(XML.self)
      try xml.detectElementTypeWithClass(Element.self)
      
      var xmlElement : XML?
      
      xml.didDecodeElement = {
        (element:ElementType) -> Void in
        if let xml = element as? XML { xmlElement = xml }
      }
      
      xml.decode { (errors) -> Void in
        XCTAssertNil(errors)
        XCTAssertNotNil(xmlElement)
        XCTAssertTrue(xmlElement?.children.count == 1)
        let element = xmlElement?.children[0]
        XCTAssertTrue(element?.message == "Hello World")
      }
    } catch {
      XCTFail()
    }
  }
    
}
