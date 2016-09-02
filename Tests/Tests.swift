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
  
  public static func decode(_ parent: ElementType?, attributes: [String : String]?, property: AnyObject?) throws -> ElementType {
    guard let message = property as? String,
      let xml = parent as? XML
      else { throw ElementsError.InvalidData }
    return Element(xml: xml, message: message)
  }

  
  enum ElementsError : Error {
    case InvalidData
  }
  
  
  let message : String
  unowned let xml : XML
  
  
  init(xml:XML,message:String) {
    self.xml = xml
    self.message = message
  }
  
  
  func parent() -> ElementType {
    return xml
  }
}


class XML : ElementType {
  
  public static func decode(_ parent: ElementType?, attributes: [String : String]?, property: AnyObject?) throws -> ElementType {
    return XML()
  }
  
  lazy var children = [Element]()
  
  func child(_ element: ElementType) {
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
