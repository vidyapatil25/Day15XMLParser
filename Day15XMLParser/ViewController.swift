//
//  ViewController.swift
//  Day15XMLParser
//
//  Created by Felix-ITS016 on 17/12/19.
//  Copyright © 2019 Felix. All rights reserved.
//

import UIKit
// http://images.apple.com/main/rss/hotnews/hotnews.rss
class ViewController: UIViewController,XMLParserDelegate,UITableViewDataSource {
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return finalItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        if indexPath.section == 0
        {
            cell.textLabel?.text = finalItems[indexPath.row]
        }
        return cell
    }
    
   
    var saxParser : XMLParser!
    var finalItems = [String]()
    var flag = 0
    var flag2 = 0
    var titles: String!
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        print(elementName)
        if elementName == "item"
        {
            flag = 1
        }
       if  flag == 1 && elementName == "title"
       {
        flag2 = 1
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
       
        if  flag2 == 1
        {
            titles = String()
            titles.append(string)
        }
        
        
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if flag2 == 1
        {
        finalItems.append(titles)
        flag = 0
        flag2 = 0
        }
        print(finalItems)
       // print(elementName)
    }
    
    
    
    
    
    
   
    

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let str = "http://images.apple.com/main/rss/hotnews/hotnews.rss"
        let url = URL(string: str)
        saxParser = XMLParser(contentsOf: url!)
        saxParser.delegate = self
        saxParser.parse()
        
        // Do any additional setup after loading the view, typically from a nib.
    }


}

