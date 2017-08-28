//
//  ViewController.swift
//  ParsingXML
//
//  Created by Anthony Rodriguez on 8/25/17.
//  Copyright © 2017 Anthony Rodriguez. All rights reserved.
//

import UIKit

class ViewController: UIViewController, NewsParserDelegate, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet weak var tableView:UITableView!
    
    var parser:NewParser?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let bundle = Bundle(for: CustomCell.self)
        let nib = UINib(nibName: "CustomViewCell", bundle: bundle)
        self.tableView.register(nib, forCellReuseIdentifier: "CustomCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
        Networking.callApi(url: "http://www.nytimes.com/services/xml/rss/nyt/US.xml") { (data, error) in
            guard error == nil else{return}
            guard let data = data else {return}
            self.parser = NewParser(xml: data, delegate: self)
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        guard let parser = self.parser else {return 0}
        guard let channel = parser.channel else {return 0}
        return channel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "CustomCell") as! CustomCell
        guard let parser = self.parser else {return cell}
        guard let channel = parser.channel else {return cell}
        
        let item:Item = channel.items[indexPath.row]
        
        guard let title = item.title else {return cell}
        guard let link = item.link else {return cell}
        guard let description = item.description else {return cell}
        guard let pubDate = item.pubDate else {return cell}
        guard let media = item.media else {
            cell.fillCell(with: title, link: link, mediaDescription: "", mediaCredit: "", itemDescription: description, pubDate: pubDate)
            return cell}
        guard let mediaDescription = media.description else {return cell}
        guard let mediaCredit = media.credit else {return cell}
        
        cell.fillCell(with: title, link: link, mediaDescription: mediaDescription, mediaCredit: mediaCredit, itemDescription: description, pubDate: pubDate)
        
        return cell

    }
}

