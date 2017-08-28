//
//  NewParser.swift
//  ParsingXML
//
//  Created by Anthony Rodriguez on 8/25/17.
//  Copyright © 2017 Anthony Rodriguez. All rights reserved.
//

import Foundation


protocol NewsParserDelegate:class
{
    
}


class NewParser:NSObject, XMLParserDelegate
{
    var currentElement = ""
    var currentString = ""
    var parser = XMLParser()
    weak var delegate:NewsParserDelegate?
    var channel:Channel?
    var currentItem:Item?
    var currentMedia:Media?
    
    override init()
    {
        super.init()
    }
    
    convenience init(xml:Data, delegate:NewsParserDelegate)
    {
        self.init()
        self.delegate = delegate
        self.parser = XMLParser(data: xml)
        parser.delegate = self
        let bool:Bool = (parser.parse())
        if bool
        {
            print("Parser finished")
            //TODO: Call Delegate method and pass info
        }
        else
        {
            print("Parse failed")
            //TODO: Call delegate method to let the user know it failed
        }
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:])
    {
        currentElement = elementName
        
        switch currentElement {
        case "channel":
            channel = Channel(items: [])
            break
        case "item":
            currentItem = Item()
            break
        case "media":
            currentMedia = Media()
            break
        default:
            break
        }
    
        print(currentElement)
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String)
    {
        currentString.append(string)
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        defer {currentString = ""}
        
        switch elementName {
        case "title":
            guard currentItem != nil else {break}
            currentItem?.title = currentString
            break
        case "link":
            guard currentItem != nil else {break}
            currentItem?.link = currentString
            break
        case "description":
            guard currentItem != nil else {break}
            guard currentMedia != nil else{currentItem?.description = currentString
                break}
            currentMedia?.description = currentString
            break
        case "pubDate":
            guard currentItem != nil else {break}
            currentItem?.pubDate = currentString
            break
        case "credit":
            guard currentMedia != nil else {break}
            currentMedia?.credit = currentString
            break
        case "url":
            guard currentMedia != nil else {break}
            currentMedia?.url = currentString
            break
        case "item":
            guard let item = currentItem else {break}
            channel?.items.append(item)
            currentItem = nil
            break
        case "media":
            guard currentItem != nil else {break}
            currentItem?.media = currentMedia
            currentMedia = nil
            break
        default:
            break
        }
        
        print(currentString)
    }
}
