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
  
  
  public var rootElement  : ElementType?
  public var filePath     : String?
  
  
  private var _parser           : NSXMLParser?
  private var _currentElements  : [ElementType]?
  private var _parserError      : ErrorType?
  
  
  private lazy var _classes   : [String:(elementType:ElementType.Type, parentElementType: ElementType.Type?)] = {
    return [String:(elementType:ElementType.Type, parentElementType: ElementType.Type?)]()
  }()
  
  
  public init(filePath:String) throws {
    super.init()
    if NSFileManager.defaultManager().fileExistsAtPath(filePath) != true { throw Error.InvalidXMLDocumentFilePath }
    self.filePath = filePath
  }
  
  
  public init(fileURL:NSURL) throws {
    super.init()
    guard let filePath = fileURL.path else { throw Error.InvalidXMLDocumentFileURL }
    self.filePath = filePath
  }
  
  
  public func detectElementTypeWithClass(elementType:AnyClass?, parentElementType:AnyClass?) throws {
    guard let element = elementType as? ElementType.Type else { throw Error.InvalidElementClass }
    let parentElement = parentElementType as? ElementType.Type
    self._classes[element.tag] = (element,parentElement)
  }
  
  
  public func decode(completionHandler: ((error:ErrorType?) -> Void)?) {
    guard let filePath = self.filePath else { completionHandler?(error:Error.InvalidXMLDocumentFilePath); return }
    guard let data = NSData(contentsOfFile: filePath) else { completionHandler?(error:Error.InvalidXMLDocumentData); return}
    self._parser = NSXMLParser(data: data)
    self._parser!.parse()
  }
  
  
  public func encode(completionHandler: ((error:ErrorType?) -> Void)?) {
  
  }
  
  
  public func parserDidStartDocument(parser: NSXMLParser) {
    
  }
  
  
  public func parserDidEndDocument(parser: NSXMLParser) {
    
  }
  
  
  public func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
    
  }
  
  
  public func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
    
  }
  
  
  public func parser(parser: NSXMLParser, foundCharacters string: String) {
    
  }
  
  
  public func parser(parser: NSXMLParser, foundCDATA CDATABlock: NSData) {
    
  }
  
  
  public func parser(parser: NSXMLParser, parseErrorOccurred parseError: NSError) {
    self._parserError = parseError
  }
}