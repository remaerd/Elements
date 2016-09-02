//: Playground - noun: a place where people can play

import Cocoa
import Elements

class Element : ElementType {
  
  public static func decode(_ parent: ElementType?, attributes: [String : String]?, property: AnyObject?) throws -> ElementType {
    guard let message = property as? String,
      let xml = parent as? Root
      else { throw ElementsError.InvalidData }
    return Element(xml: xml, message: message)
  }
  
  
  enum ElementsError : Error {
    case InvalidData
  }
  
  
  let message : String
  unowned let xml : Root
  
  
  init(xml:Root,message:String) {
    self.xml = xml
    self.message = message
  }
  
  func parent() -> ElementType {
    return xml
  }
}


class Root : ElementType {
  
  static var element : String
  {
    get {
      return "xml";
    }
  }
  
  static func decode(_ parent: ElementType?, attributes: [String : String]?, property: AnyObject?) throws -> ElementType {
    return Root()
  }
  
  lazy var children = [Element]()
  
  func child(_ element: ElementType) {
    if let child = element as? Element { self.children.append(child) }
  }
}

var xmlString = "<xml><elements><element>Hello World</element><element>Hello Remaerd</element></elements></xml>"
let xml = Elements.XML(xml: xmlString, models: [Root.self,Element.self])

xml.decode { (rootElements, errors) -> Void in
  if ((errors) != nil) { print(errors) }
  let xmlElement = rootElements?[0] as? Root
  print(xmlElement?.children[0].message)
}
