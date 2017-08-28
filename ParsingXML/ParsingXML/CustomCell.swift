//
//  CustomCell.swift
//  ParsingXML
//
//  Created by Anthony Rodriguez on 8/27/17.
//  Copyright © 2017 Anthony Rodriguez. All rights reserved.
//

import Foundation
import UIKit

class CustomCell:UITableViewCell
{
    @IBOutlet weak var title:UILabel!
    @IBOutlet weak var link:UILabel!
    @IBOutlet weak var mediaDescription:UILabel!
    @IBOutlet weak var mediaCredit:UILabel!
    @IBOutlet weak var itemDescription:UILabel!
    @IBOutlet weak var pubDate:UILabel!
    
    func fillCell(with title:String, link:String, mediaDescription:String, mediaCredit:String, itemDescription:String, pubDate:String)
    {
        self.title.text = title
        self.link.text = link
        self.mediaDescription.text = mediaDescription
        self.mediaCredit.text = mediaCredit
        self.itemDescription.text = itemDescription
        self.pubDate.text = pubDate
    }
}
