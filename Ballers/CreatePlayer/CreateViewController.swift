//
//  CreateViewController.swift
//  Ballers
//
//  Created by Калинин Артем Валериевич on 26.08.2020.
//  Copyright © 2020 Калинин Артем Валериевич. All rights reserved.
//

import UIKit
import CoreData

class CreateViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var clubNameText: UITextField!
    @IBOutlet weak var numberOfPlayer: UITextField!
    @IBOutlet weak var addButtonOutlet: UIButton!
    @IBOutlet weak var playerWeight: UITextField!
    @IBOutlet weak var playerHeight: UITextField!
    @IBOutlet weak var workingFood: UISegmentedControl!
    @IBOutlet weak var birthDayText: UITextField!
    @IBOutlet weak var photoOfBaller: UIImageView!
    @IBOutlet weak var contractDate: UITextField!
    @IBOutlet weak var prioritySegment: UISegmentedControl!
    
    //Выбор позиции
    @IBOutlet weak var positionKZ: UIButton!
    @IBOutlet weak var positionGoalKeeper: UIButton!
    @IBOutlet weak var positionCZ: UIButton!
    @IBOutlet weak var positionCPZ: UIButton!
    @IBOutlet weak var positionKPZ: UIButton!
    @IBOutlet weak var positionCN: UIButton!
    @IBOutlet weak var positionKN: UIButton!
    
    @IBOutlet weak var clearPosition: UIButton!
    
    
    //датапикер для Дня рождения
    let dataPicker = UIDatePicker()
    //Массив значений для Сегмента "Рабочая нога"
    let workingLeg = ["Левая", "Обе", "Правая"]
    var leg = "Обе"
    //для сегмента "Приоритет"
    var playerPhoto: UIImage?
    var colorOfPriority = UIColor.green
    let arrayOfPriority = [UIColor.green, UIColor.orange, UIColor.red]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cotract()
        birthday()
        setButton()
        setPositionButton()
        nameText.delegate = self
        clubNameText.delegate = self
        numberOfPlayer.delegate = self
        playerWeight.delegate = self
        playerHeight.delegate = self
        workingFood.addTarget(self, action: #selector(selected), for: .valueChanged)
        prioritySegment.addTarget(self, action: #selector(selectPriority), for: .valueChanged)
        photoOfBaller.layer.cornerRadius = 20
    }
    
    func setPositionButton() {
        positionKZ.layer.cornerRadius = 12
        positionGoalKeeper.layer.cornerRadius = 12
        positionCZ.layer.cornerRadius = 12
        positionCPZ.layer.cornerRadius = 12
        positionKPZ.layer.cornerRadius = 12
        positionCN.layer.cornerRadius = 12
        positionKN.layer.cornerRadius = 12
    }
    
    // MARK: - Устанавливаем приоритет
    @objc func selectPriority(target: UISegmentedControl) {
        if target == self.prioritySegment {
            let segmentIndex = target.selectedSegmentIndex
            colorOfPriority = self.arrayOfPriority[segmentIndex]
        }
    }
    // MARK: - Устанавливаем дату рождения
    func birthday() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolBar.setItems([doneBtn], animated: true)
        birthDayText.inputAccessoryView = toolBar
        dataPicker.datePickerMode = .date
        dataPicker.datePickerStyle == .compact
        birthDayText.inputView = dataPicker
    }
    
    @objc func donePressed() {
        let forrmater = DateFormatter()
        forrmater.dateStyle = .short
        forrmater.timeStyle = .none
        birthDayText.text = forrmater.string(from: dataPicker.date)
        self.view.endEditing(true)
    }
    
    //Окружность кнопки
    func setButton() {
        addButtonOutlet.layer.cornerRadius = 12
    }
    
    //Устанавливаем Сегмент контролле (Рабочая нога)
    @objc func selected(target: UISegmentedControl) {
        if target == self.workingFood {
            let segmentIndex = target.selectedSegmentIndex
            leg = self.workingLeg[segmentIndex]
        }
    }
    
    // MARK: - Дата контракта
    func cotract() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressedForContract))
        toolBar.setItems([doneBtn], animated: true)
        contractDate.inputAccessoryView = toolBar
        dataPicker.datePickerMode = .date
        dataPicker.datePickerStyle == .compact
        contractDate.inputView = dataPicker
    }
    
    @objc func donePressedForContract() {
        let forrmater = DateFormatter()
        forrmater.dateStyle = .short
        forrmater.timeStyle = .none
        contractDate.text = forrmater.string(from: dataPicker.date)
        self.view.endEditing(true)
    }
    
    
    // MARK: - Кнопка добавить
    @IBAction func addButtonAction(_ sender: Any) {
        guard let photo = playerPhoto else {return}
        let newPlayer = Player(name: nameText.text ?? "", club: clubNameText.text ?? "", number: numberOfPlayer.text ?? "", birthDay: birthDayText.text ?? "", weight: playerWeight.text ?? "", height: playerHeight.text ?? "", workingLeg: leg, photo: photo, contract: contractDate.text ?? "", priority: colorOfPriority, position: arrayOfPosition)
        
        array.append(newPlayer)
        //Очищаем поля заполнения игрока
        nameText.text = ""
        clubNameText.text = ""
        numberOfPlayer.text = ""
        birthDayText.text = ""
        playerWeight.text = ""
        playerHeight.text = ""
        contractDate.text = ""
        photoOfBaller.image = .none
        positionKZ.backgroundColor = .systemGray5
        positionGoalKeeper.backgroundColor = .systemGray5
        positionCZ.backgroundColor = .systemGray5
        positionCPZ.backgroundColor = .systemGray5
        positionKPZ.backgroundColor = .systemGray5
        positionCN.backgroundColor = .systemGray5
        positionKN.backgroundColor = .systemGray5
        
        let alert = UIAlertController(title: "Игрок добавлен в базу", message: "Игрока можно найти в общей базе", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func AddPhoto(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        image.allowsEditing = true //false
        present(image, animated:  true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            photoOfBaller.image = image
            playerPhoto = image
        } else {
            print("Nothing HERE")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - Убрать клавиатуру
    func textFieldShouldReturn(_ text: UITextField) -> Bool {
        switch text {
        case nameText:
            nameText.resignFirstResponder()
            return true;
        case clubNameText:
            clubNameText.resignFirstResponder()
            return true;
        case numberOfPlayer:
            numberOfPlayer.resignFirstResponder()
            return true;
        case playerWeight:
            playerWeight.resignFirstResponder()
            return true;
        case playerHeight:
            playerHeight.resignFirstResponder()
            return true;
        case workingFood:
            workingFood.resignFirstResponder()
            return true;
        case birthDayText:
            birthDayText.resignFirstResponder()
            return true;
        case contractDate:
            contractDate.resignFirstResponder()
            return true
        default:
            print("no")
        }
        return true
    }
    
    // MARK: - Кнопки Позиции
    //массив Позиций игрока
    var arrayOfPosition = [String]()
    //Функция, чтобы позиций было не больше 3-х
    func calculate(posittion: String) {
        if arrayOfPosition.count < 3 {
            arrayOfPosition.append(posittion)
        } else {
            print("Больше нельзя")
        }
    }
    
    //кнопки Позиций (Действия)
    @IBAction func actionKZ(_ sender: Any) {
        if arrayOfPosition.count < 3 {
            calculate(posittion: "КЗ")
            UIView.animate(withDuration: 1) {
                self.positionKZ.backgroundColor = #colorLiteral(red: 1, green: 0.5241836905, blue: 0.5077878833, alpha: 1)
                print(self.arrayOfPosition)
            }
        }
    }
    @IBAction func actionGoalKeeper(_ sender: Any) {
        if arrayOfPosition.count < 3 {
            calculate(posittion: "Вратарь")
            UIView.animate(withDuration: 1) {
                self.positionGoalKeeper.backgroundColor = #colorLiteral(red: 1, green: 0.5241836905, blue: 0.5077878833, alpha: 1)
                print(self.arrayOfPosition)
            }
        }
    }
    @IBAction func actionCZ(_ sender: Any) {
        if arrayOfPosition.count < 3 {
            calculate(posittion: "ЦЗ")
            UIView.animate(withDuration: 1) {
                self.positionCZ.backgroundColor = #colorLiteral(red: 1, green: 0.5241836905, blue: 0.5077878833, alpha: 1)
                print(self.arrayOfPosition)
            }
        }
    }
    @IBAction func actionCPZ(_ sender: Any) {
        if arrayOfPosition.count < 3 {
            calculate(posittion: "ЦПЗ")
            UIView.animate(withDuration: 1) {
                self.positionCPZ.backgroundColor = #colorLiteral(red: 1, green: 0.5241836905, blue: 0.5077878833, alpha: 1)
                print(self.arrayOfPosition)
            }
        }
    }
    @IBAction func actionKPZ(_ sender: Any) {
        if arrayOfPosition.count < 3 {
            calculate(posittion: "КПЗ")
            UIView.animate(withDuration: 1) {
                self.positionKPZ.backgroundColor = #colorLiteral(red: 1, green: 0.5241836905, blue: 0.5077878833, alpha: 1)
                print(self.arrayOfPosition)
            }
        }
    }
    @IBAction func actionCN(_ sender: Any) {
        if arrayOfPosition.count < 3 {
            calculate(posittion: "ЦН")
            UIView.animate(withDuration: 1) {
                self.positionCN.backgroundColor = #colorLiteral(red: 1, green: 0.5241836905, blue: 0.5077878833, alpha: 1)
                print(self.arrayOfPosition)
            }
        }
    }
    @IBAction func actionKN(_ sender: Any) {
        if arrayOfPosition.count < 3 {
            calculate(posittion: "КН")
            UIView.animate(withDuration: 1) {
                self.positionKN.backgroundColor = #colorLiteral(red: 1, green: 0.5241836905, blue: 0.5077878833, alpha: 1)
                print(self.arrayOfPosition)
            }
        } else {
            arrayOfPosition.removeLast()
        }
    }
    
    @IBAction func actionClearPosition(_ sender: Any) {
        arrayOfPosition.removeAll()
        positionKZ.backgroundColor = .systemGray5
        positionGoalKeeper.backgroundColor = .systemGray5
        positionCZ.backgroundColor = .systemGray5
        positionCPZ.backgroundColor = .systemGray5
        positionKPZ.backgroundColor = .systemGray5
        positionCN.backgroundColor = .systemGray5
        positionKN.backgroundColor = .systemGray5
    }
}


