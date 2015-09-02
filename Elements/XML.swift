//
//  XML.swift
//  Elements
//
//  Created by Sean Cheng on 8/26/15.
//  Copyright © 2015 Sean Cheng. All rights reserved.
//

import Foundation

public final class XML : NSObject, NSXMLParserDelegate {
  
  public enum Error : ErrorType {
    case InvalidXMLDocumentFilePath
    case InvalidXMLDocumentFileURL
    case InvalidXMLDocumentData
    case InvalidElementClass
    case InvalidParentElementClass
  }
  
  
  public var xmlData  : NSData?
  
  private var _parser               : NSXMLParser?
  private var _parserErrors         = [ErrorType]()
  private var _currentAttributes    : [String:String]?
  private var _currentElementType   : ElementType.Type?
  private var _rootElementType      : ElementType.Type?
  
  
  private lazy var _rootElements : [ElementType] = {
    return [ElementType]()
  }()
  
  
  private lazy var _currentElements : [ElementType] = {
    return [ElementType]()
  }()
  
  
  private lazy var _models : [String:ElementType.Type] = {
    return [String:ElementType.Type]()
  }()
  
  
  public convenience init(filePath:String, models:[ElementType.Type]) throws {
    if NSFileManager.defaultManager().fileExistsAtPath(filePath) != true { throw Error.InvalidXMLDocumentFilePath }
    guard let data = NSData(contentsOfFile: filePath) else { throw Error.InvalidXMLDocumentData }
    self.init(data: data,models: models)
  }
  
  
  public convenience init(fileURL:NSURL, models:[ElementType.Type]) throws {
    guard let filePath = fileURL.path else { throw Error.InvalidXMLDocumentFileURL }
    try self.init(filePath:filePath, models: models)
  }
  
  
  public convenience init(xml:String, models:[ElementType.Type]) {
    let data = xml.dataUsingEncoding(NSUTF8StringEncoding)!
    self.init(data: data,models: models)
  }
  
  
  public init(data: NSData, models:[ElementType.Type]) {
    self.xmlData = data
    super.init()
    for elementType in models { self._models[elementType.element] = elementType }
    self._rootElementType = models.first
  }
  
  
  public func decode(completionHandler: ((rootElements:[ElementType]?, errors:[ErrorType]?) -> Void)?) {
    guard let data = self.xmlData else { completionHandler?(rootElements:nil, errors: [Error.InvalidXMLDocumentData]); return }
    self._parser = NSXMLParser(data:data)
    self._parser?.delegate = self
    let result = self._parser!.parse()
    if result == true { completionHandler?(rootElements: self._rootElements, errors: nil) }
    else { completionHandler?(rootElements:nil, errors: _parserErrors) }
    self._parser = nil
  }
  
  
  public func encode(completionHandler: ((errors:[ErrorType]?) -> Void)?) {
    
  }
}


extension XML {
  
  public func parserDidStartDocument(parser: NSXMLParser) {
    self._rootElements.removeAll()
    self._currentElements.removeAll()
    self._parserErrors.removeAll()
  }
  
  
  public func parserDidEndDocument(parser: NSXMLParser) {
    
  }
  
  
  public func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
    if self._currentElementType != nil { self.createElement(self._currentElementType!) }
    self._currentElementType = _models[elementName]
    self._currentAttributes = attributeDict
  }
  
  
  public func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
    self._currentAttributes = nil
    self._currentElementType = nil
    if self._currentElements.count > 0 { self._currentElements.removeLast() }
  }
  
  
  public func parser(parser: NSXMLParser, foundCharacters string: String) {
    guard let elementType = self._currentElementType else { return }
    self.createElement(elementType, property: string)
  }
  
  
  public func parser(parser: NSXMLParser, foundCDATA CDATABlock: NSData) {
    guard let elementType = self._currentElementType else { return }
    self.createElement(elementType, property: CDATABlock)
  }
  
  
  public func parser(parser: NSXMLParser, validationErrorOccurred validationError: NSError) {
    self._parserErrors.append(validationError)
  }
  
  
  public func parser(parser: NSXMLParser, parseErrorOccurred parseError: NSError) {
    self._parserErrors.append(parseError)
  }
}


extension XML {
  
  private func createElement(classType:ElementType.Type, property: AnyObject? = nil) {
    do {
      let element = try classType.init(parent: self._currentElements.last, attributes: self._currentAttributes, property: property)
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