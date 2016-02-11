//
//  ViewController.swift
//  REALM2.0
//
//  Created by Vijay Sanghavi on 11/17/15.
//  Copyright © 2015 Vijay Sanghavi. All rights reserved.
//

import UIKit
import RealmSwift

class DOG: Object
{
    dynamic var name = ""
    dynamic var owner: Person?
    
    //        override static func indexedProperties() -> [String]
    //        {
    //            return ["name"];
    //        }
}

class Person: Object
{
    dynamic var name = ""
    dynamic var age = 0
    let dogs = List<DOG>()
}

class ViewController: UIViewController
{
    let realm = try! Realm()

    @IBOutlet weak var tfDogName: UITextField!
    @IBOutlet weak var tfPersonName: UITextField!
    @IBOutlet weak var tfPersonAge: UITextField!
  

    @IBOutlet weak var lblDogName: UITextField!
    @IBOutlet weak var lblPersonName: UITextField!
    @IBOutlet weak var lblPersonAge: UITextField!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        try! realm.write()
            {
                let person = self.realm.create(Person.self, value: ["Jane", 27]) //, ["hachiko", "nawab"]
                
                person.age = 28
        }
    }
    
    func writeDogValues(dogName: String)
    {
        let dog = DOG()
        
        dog.name = dogName
        
        try! realm.write()
            {
                self.realm.add(dog)
        }
    }
    
    func writeValues(personName: String, personAge: Int)
    {
        let person = Person()
        
        //we can write values in 3 ways
        person.name = personName
        person.age = personAge
        
//        // (2) Create a Dog object from a dictionary
//        let myOtherDog = Person(value: ["name" : "Pluto", "age": 3])
//        
//        // (3) Create a Dog object from an array
//        let myThirdDog = Person(value: ["Fido", 5])
//        
//        // You only need to do this once (per thread)
        
        // Add to the Realm inside a transaction
        try! realm.write
        {
//            self.realm.add([myDog, myOtherDog,myThirdDog])
            self.realm.add(person)
        }
    }
    
    func readValues()
    {
        let dogs = self.realm.objects(DOG)
        let persons = self.realm.objects(Person)
        
        print("Dogs \(dogs) \n\n Persons \(persons)")
    }
    
    @IBAction func writeSegmentAction(sender: UISegmentedControl)
    {
        if sender.selectedSegmentIndex == 0
        {
            if  tfDogName.text != ""
            {
                self.writeDogValues(tfDogName.text!)
            }
            else
            {
                let alert = UIAlertController(title: "Alert", message: "Please enter dog name", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
        else if sender.selectedSegmentIndex == 1
        {
            if tfPersonName.text != "" && tfPersonAge.text != ""
            {
                self.writeValues(tfPersonName.text!, personAge: Int(tfPersonAge.text!)!)
            }
            else
            {
                let alert = UIAlertController(title: "Alert", message: "Please enter all details of person", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func viewSegmentAction(sender: UISegmentedControl)
    {
        self.readValues()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}

