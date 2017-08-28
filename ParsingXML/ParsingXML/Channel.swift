//
//  Channel.swift
//  ParsingXML
//
//  Created by Anthony Rodriguez on 8/25/17.
//  Copyright © 2017 Anthony Rodriguez. All rights reserved.
//

import Foundation

class Channel
{
    var items:[Item]
    
    init(items:[Item])
    {
        self.items = items
    }
}

class Item
{
    var title:String?
    var link:String?
    var media:Media?
    var description:String?
    var pubDate:String?
    
    /*init(title:String, link:String, media:Media, description:String, pubDate:String)
    {
        self.title = title
        self.link = link
        self.media = media
        self.description = description
        self.pubDate = pubDate
    }*/
}

class Media
{
    var description:String?
    var url:String?
    var credit:String?
    
    /*init(description:String, url:String, credit:String)
    {
        self.description = description
        self.url = url
        self.credit = credit
    }*/
}
