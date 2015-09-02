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
  
  
  let message : String!
  let xml     : XML!
  
  
  required init(parent: ElementType?, attributes: [String : String]?, property: AnyObject?) throws {
    self.message = property as? String
    self.xml = parent as? XML
    if self.message == nil && self.xml == nil { throw Error.InvalidMessage }
  }
  
  
  func parent() -> ElementType {
    return xml
  }
}


class XML : ElementType {
  
  var children : [Element]
  
  required init(parent: ElementType?, attributes: [String : String]?, property: AnyObject?) throws {
    self.children = [Element]()
  }
  
  
  func child(element: ElementType) {
    if let child = element as? Element { self.children.append(child) }
  }
}



class Tests: XCTestCase {
  
  func testDefineElementType() {
    print(XML.element)
    XCTAssertTrue(XML.element == "xml")
  }
  
  
  func testDecode() {
    
    let xmlString = "<xml><elements><element>Hello World</element><element>Hello Remaerd</element></elements></xml>"
    let classes : [ElementType.Type] = [XML.self,Element.self]
    let xml = Elements.XML(xml: xmlString, models: classes)

    xml.decode { (rootElements, errors) -> Void in
      XCTAssertNil(errors)
      XCTAssertTrue(rootElements?.count == 1)
      let xmlElement = rootElements?[0] as? XML
      XCTAssertNotNil(xmlElement)
      XCTAssertTrue(xmlElement?.children.count == 2)
      let element = xmlElement?.children[0]
      XCTAssertTrue(element?.message == "Hello World")
    }
  }
  
}
