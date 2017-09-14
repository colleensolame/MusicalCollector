//
//  ViewController.swift
//  MusicalCollector
//
//  Created by Colleen Ng on 9/14/17.
//  Copyright © 2017 ZND Code. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var musicalTableView: UITableView!
    
    var musicals: [Musical] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        musicalTableView.dataSource = self
        musicalTableView.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            musicals = try context.fetch(Musical.fetchRequest())
            musicalTableView.reloadData()
        } catch {
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let musical = musicals[indexPath.row]
        cell.textLabel?.text = musical.title
        cell.imageView?.image = UIImage(data: musical.image as Data!)
        return cell
    }
}

