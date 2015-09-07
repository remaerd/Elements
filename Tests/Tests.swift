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
    case InvalidData
  }
  
  
  let message : String
  unowned let xml : XML
  
  
  init(xml:XML,message:String) {
    self.xml = xml
    self.message = message
  }
  
  
  static func decode(parent: ElementType?, attributes: [String : AnyObject]?, property: AnyObject?) throws -> ElementType {
    guard let message = property as? String,
              xml = parent as? XML
      else { throw Error.InvalidData }
    return Element(xml: xml, message: message)
  }
  
  
  func parent() -> ElementType {
    return xml
  }
}


class XML : ElementType {
  
  lazy var children = [Element]()
  
  
  static func decode(parent: ElementType?, attributes: [String : AnyObject]?, property: AnyObject?) throws -> ElementType {
    return XML()
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
