//
//  ViewController.swift
//  Ballers
//
//  Created by Калинин Артем Валериевич on 26.08.2020.
//  Copyright © 2020 Калинин Артем Валериевич. All rights reserved.
//

import UIKit
import CoreData

class CollectionViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    //Поисковик
    let searchController = UISearchController(searchResultsController: nil)
    var filteredPlayer: [Player] = []
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        setSearchController()
    }
    
    func setSearchController() {
        // 1
        searchController.searchResultsUpdater = self
        // 2
        searchController.obscuresBackgroundDuringPresentation = false
        // 3
        searchController.searchBar.placeholder = "Введите имя, клуб или рабочую ногу"
        // 4
        navigationItem.searchController = searchController
        // 5
        definesPresentationContext = true
    }
    
    // MARK: - Категории поиска
    func filterContentForSearchText(_ searchText: String,
                                    category: Player? = nil) {
        filteredPlayer = array.filter { (player: Player) -> Bool in
            return player.name.lowercased().contains(searchText.lowercased()) ||              player.club.lowercased().contains(searchText.lowercased()) ||
                player.workingLeg.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
}


extension CollectionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredPlayer.count
        }
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifire", for: indexPath) as? PlayerTableViewCell else {return PlayerTableViewCell()}
        let searchingPlayer: Player
        if isFiltering {
            searchingPlayer = filteredPlayer[indexPath.row]
        } else {
            searchingPlayer = array[indexPath.row]
        }
        cell.priorityView.backgroundColor = searchingPlayer.priority
        cell.nameLable.text = "\(searchingPlayer.name) (\(age(birthday: searchingPlayer.birthDay)))"
        cell.detailTextLabel?.text = searchingPlayer.name
        return cell
    }
    
    public func age(birthday: String) -> String {
        let dateFormatter : DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.mm.yyyy"
            formatter.locale = Locale(identifier: "en_US_POSIX")
            return formatter
        }()
        
        let birthday = dateFormatter.date(from: birthday)
        let timeInterval = birthday?.timeIntervalSinceNow
        let age = abs(Int(timeInterval! / 31556926.0))
        return String(age)
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
        if isFiltering {
            let filterBaller = filteredPlayer[tableView.indexPathForSelectedRow!.row]
            vc.baller = filterBaller
        } else {
            let baller = array[tableView.indexPathForSelectedRow!.row]
            vc.baller = baller
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
}

extension CollectionViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
}
