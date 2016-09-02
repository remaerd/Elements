//
//  XML.swift
//  Elements
//
//  Created by Sean Cheng on 8/26/15.
//  Copyright © 2015 Sean Cheng. All rights reserved.
//

import Foundation

public final class XML : NSObject, XMLParserDelegate {
  
  public enum XMLError : Error {
    case invalidXMLDocumentFilePath
    case invalidXMLDocumentData
    case invalidElementClass
    case invalidParentElementClass
  }
  
  
  public var xmlData  : Data?
  
  fileprivate var _parser               : XMLParser?
  fileprivate var _parserErrors         = [Error]()
  fileprivate var _currentAttributes    : [String:String]?
  fileprivate var _currentElementType   : ElementType.Type?
  fileprivate var _rootElementType      : ElementType.Type?
  
  
  fileprivate lazy var _rootElements : [ElementType] = {
    return [ElementType]()
  }()
  
  
  fileprivate lazy var _currentElements : [ElementType] = {
    return [ElementType]()
  }()
  
  
  fileprivate lazy var _models : [String:ElementType.Type] = {
    return [String:ElementType.Type]()
  }()
  
  
  public convenience init(filePath:String, models:[ElementType.Type]) throws {
    if FileManager.default.fileExists(atPath: filePath) != true { throw XMLError.invalidXMLDocumentFilePath }
    guard let data = try? Data(contentsOf: URL(fileURLWithPath: filePath)) else { throw XMLError.invalidXMLDocumentData }
    self.init(data: data,models: models)
  }
  
  
  public convenience init(fileURL:URL, models:[ElementType.Type]) throws {
    try self.init(filePath:fileURL.path, models: models)
  }
  
  
  public convenience init(xml:String, models:[ElementType.Type]) {
    let data = xml.data(using: String.Encoding.utf8)!
    self.init(data: data,models: models)
  }
  
  
  public init(data: Data, models:[ElementType.Type]) {
    self.xmlData = data
    super.init()
    for elementType in models { self._models[elementType.element] = elementType }
    self._rootElementType = models.first
  }
  
  
  public func decode(_ completionHandler: ((_ rootElements:[ElementType]?, _ errors:[Error]?) -> Void)?) {
    guard let data = self.xmlData else { completionHandler?(nil, [XMLError.invalidXMLDocumentData]); return }
    self._parser = XMLParser(data:data)
    self._parser?.delegate = self
    _ = self._parser!.parse()
    if _parserErrors.count == 0 { completionHandler?(self._rootElements, nil) }
    else { completionHandler?(nil, _parserErrors) }
    self._parser = nil
  }
  
  
  public func encode(_ completionHandler: ((_ errors:[Error]?) -> Void)?) {
    
  }
}


extension XML {
  
  public func parserDidStartDocument(_ parser: XMLParser) {
    self._rootElements.removeAll()
    self._currentElements.removeAll()
    self._parserErrors.removeAll()
  }
  
  
  public func parserDidEndDocument(_ parser: XMLParser) {
    
  }
  
  
  public func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
    if self._currentElementType != nil { self.createElement(self._currentElementType!) }
    self._currentElementType = _models[elementName]
    self._currentAttributes = attributeDict
  }
  
  
  public func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
    self._currentAttributes = nil
    self._currentElementType = nil
    if self._currentElements.count > 0 { self._currentElements.removeLast() }
  }
  
  
  public func parser(_ parser: XMLParser, foundCharacters string: String) {
    guard let elementType = self._currentElementType else { return }
    self.createElement(elementType, property: string as AnyObject?)
  }
  
  
  public func parser(_ parser: XMLParser, foundCDATA CDATABlock: Data) {
    guard let elementType = self._currentElementType else { return }
    self.createElement(elementType, property: CDATABlock as AnyObject?)
  }
  
  
  public func parser(_ parser: XMLParser, validationErrorOccurred validationError: Error) {
    self._parserErrors.append(validationError)
  }
  
  
  public func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
    self._parserErrors.append(parseError)
  }
}


extension XML {
  
  fileprivate func createElement(_ classType:ElementType.Type, property: AnyObject? = nil) {
    do {
      let element = try classType.decode(self._currentElements.last, attributes: self._currentAttributes, property: property)
      self._currentElements.append(element)
      if self._currentElements.count > 1 {
        let previousElement = self._currentElements[self._currentElements.count - 2]
        previousElement.child(element)
      }
      if self._rootElementType == classType { self._rootElements.append(element) }
    } catch {
      self._parserErrors.append(error)
    }
  }
}
