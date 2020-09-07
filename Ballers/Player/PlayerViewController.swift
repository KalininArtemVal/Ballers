//
//  PlayerViewController.swift
//  Ballers
//
//  Created by Калинин Артем Валериевич on 26.08.2020.
//  Copyright © 2020 Калинин Артем Валериевич. All rights reserved.
//

import UIKit

class PlayerViewController: UIViewController {
    
    
    @IBOutlet weak var numberLable: UILabel!
    @IBOutlet weak var clubLable: UILabel!
    @IBOutlet weak var imageLable: UIImageView!
    
    @IBOutlet weak var birthdate: UILabel!
    @IBOutlet weak var playerWeight: UILabel!
    @IBOutlet weak var playerHeight: UILabel!
    @IBOutlet weak var workingLeg: UILabel!
    @IBOutlet weak var contractFor: UILabel!
    @IBOutlet weak var ageLable: UILabel!
    @IBOutlet weak var priorityColor: UIView!
    
    
    var baller: Player?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageLable.layer.cornerRadius = 20
        guard let baller = baller else {return}
        title = "\(baller.name) #\(baller.number)"
        numberLable.text = baller.number
        clubLable.text = baller.club
        birthdate.text = baller.birthDay
        playerWeight.text = baller.weight
        playerHeight.text = baller.height
        workingLeg.text = baller.workingLeg
        imageLable.image = baller.photo
        contractFor.text = baller.contract
        setPriority()
        priorityColor.backgroundColor = baller.priority
        ageLable.text = "(\(age(birthday: baller.birthDay)))"
    }
    
    
    
    
    func setPriority() {
        priorityColor.layer.cornerRadius = priorityColor.layer.bounds.size.width / 2
    }
    
    func age(birthday: String) -> String {
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
}




