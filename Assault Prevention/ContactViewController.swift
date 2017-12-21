//
//  contactViewController.swift
//  Assault Prevention
//
//  Created by Alaeldin Tirba on 12/9/17.
//  Copyright © 2017 Alaeldin Tirba. All rights reserved.
//

import UIKit

class ContactViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func viewDidLoad() {
        tableView.dataSource = self
        tableView.delegate = self
    }
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let identifier = "contactCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        return cell!
    }
    
   
}
