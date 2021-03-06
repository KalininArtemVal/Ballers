//
//  Player.swift
//  Ballers
//
//  Created by Калинин Артем Валериевич on 26.08.2020.
//  Copyright © 2020 Калинин Артем Валериевич. All rights reserved.
//

import UIKit



struct Player {
    var name: String
    var club: String
    var number: String
    var birthDay: String
    var weight: String
    var height: String
    var workingLeg: String
    var photo: UIImage
    var contract: String
    var priority: UIColor
    var position: [String]
}

//пробные экземпляры Игрока
let player = Player(name: "Бабкин Николай", club: "ЦСК", number: "13", birthDay: "27.10.1998", weight: "70", height: "178", workingLeg: "Правая", photo: UIImage(named: "T0LvuIFejY0")!, contract: "13.02.2025", priority: UIColor.green, position: ["Защитник"])
let player1 = Player(name: "Калинин Артем", club: "Спартак", number: "7", birthDay: "18.02.1990", weight: "78", height: "180", workingLeg: "Правая", photo: UIImage(named: "T0LvuIFejY0")!, contract: "13.02.2025", priority: UIColor.green, position: ["Вратарь"])
var array = [player, player1]


