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
    //новые
    @IBOutlet weak var playerWeight: UITextField!
    @IBOutlet weak var playerHeight: UITextField!
    @IBOutlet weak var workingFood: UISegmentedControl!
    @IBOutlet weak var birthDayText: UITextField!
    
    @IBOutlet weak var photoOfBaller: UIImageView!
    
    @IBOutlet weak var contractDate: UITextField!
    
    
    let dataPicker = UIDatePicker()
    let workingLeg = ["Левая", "Обе", "Правая"]
    var leg = "Обе"
    var playerPhoto: UIImage?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        saveData()
        cotract()
        birthday()
        setButton()
        nameText.delegate = self
        clubNameText.delegate = self
        numberOfPlayer.delegate = self
        workingFood.addTarget(self, action: #selector(selected), for: .valueChanged)
        photoOfBaller.layer.cornerRadius = 20
    }
    
    // MARK: - Core Date
//    func saveData() {
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let context = appDelegate.persistentContainer.viewContext
//        
//        guard let entity = NSEntityDescription.entity(forEntityName: "Player", in: context) else { return }
//        
//        let player = NSManagedObject(entity: entity, insertInto: context)
//        player.setValue(nameText, forKey: "name")
//        
//        do {
//            try context.save()
//        } catch let error as NSError {
//            print("could not save")
//        }
//        
//        fetchData()
//    }
//    
//    
//    func fetchData() {
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
//         let context = appDelegate.persistentContainer.viewContext
//         let fetchData = NSFetchRequest<NSFetchRequestResult>(entityName: "Player")
//
//        do {
//            let result = try context.fetch(fetchData)
//            for data in result as! [NSManagedObject]{
//                 print(data.value(forKeyPath: "name") as Any)
//            }
//        }catch {
//            print("ERRoR")
//        }
//    }
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
        let newPlayer = Player(name: nameText.text ?? "", club: clubNameText.text ?? "", number: numberOfPlayer.text ?? "", birthDay: birthDayText.text ?? "", weight: playerWeight.text ?? "", height: playerHeight.text ?? "", workingLeg: leg, photo: photo, contract: contractDate.text ?? "")
        
        array.append(newPlayer)
        nameText.text = ""
        clubNameText.text = ""
        numberOfPlayer.text = ""
        birthDayText.text = ""
        playerWeight.text = ""
        playerHeight.text = ""
        contractDate.text = ""
        
        let alert = UIAlertController(title: "Игрок добавлен в базу", message: "Игрока можно найти в общей базе", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
        
        //ПРОБУЕМ
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
        default:
            print("no")
        }
        return true
    }
    
}


