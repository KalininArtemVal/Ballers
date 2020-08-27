//
//  ViewController.swift
//  Ballers
//
//  Created by Калинин Артем Валериевич on 26.08.2020.
//  Copyright © 2020 Калинин Артем Валериевич. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
}



extension CollectionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifire", for: indexPath)
        let player = array[indexPath.row]
        cell.textLabel?.text = player.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            array.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteButton = UITableViewRowAction(style: .default, title: "Удалить игрока") { (action, indexPath) in
            self.tableView.dataSource?.tableView!(self.tableView, commit: .delete, forRowAt: indexPath)
            return
        }
        deleteButton.backgroundColor = UIColor.systemPink
        return [deleteButton]
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(identifier: "PlayerViewController") as? PlayerViewController else { return }
        let baller = array[tableView.indexPathForSelectedRow!.row]
        vc.baller = baller
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    
}

