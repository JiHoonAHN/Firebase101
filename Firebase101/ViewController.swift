//
//  ViewController.swift
//  Firebase101
//
//  Created by Ji-hoon Ahn on 2021/02/26.
//

import UIKit
import Firebase
class ViewController: UIViewController {
    let db = Database.database().reference()
    
    @IBOutlet weak var dataLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateLabel()
        saveBasicTypes()
        
    }

    
    
    func updateLabel(){
        db.child("firstData").observeSingleEvent(of: .value){ snapshot in
            print("--> \(snapshot)")
        
            let value = snapshot.value as? String ?? ""
            DispatchQueue.main.async {
                self .dataLabel.text = value
            }
        }
    }

}
extension ViewController{
    func saveBasicTypes(){
        //Firebase child ("key").setValue(Value)
        //- string, number, dictionary, array
        
        db.child("int").setValue(3)
        db.child("double").setValue(3.5)
        db.child("str").setValue("string value - 여러분 안녕")
        db.child("array").setValue(["a","b","c"])
        db.child("dict").setValue(["id":"anyID","age":10,"city":"Seoul"])
    }
    
    func saveCustomers(){
        // 책가게
        // 사용자를 저장하겠다
        // 모델 Customer + Book
        
        let books = [Book(title: "Good to Great", author: "Someone"),Book(title: "Hacking Growth", author: "Somebody")]
        let Customer1 = Customer(id: "\(Customer.id)", name: "son", books: books)
        Customer.id += 1
        let Customer2 = Customer(id: "\(Customer.id)", name: "Dele", books: books)
        Customer.id += 1
        let Customer3 = Customer(id: "\(Customer.id)", name: "Kane", books: books)
        Customer.id += 1
        db.child("customers").child(Customer1.id).setValue(Customer1.toDictionary)
    }
    
}
struct Customer {
    let id: String
    let name: String
    let books: [Book]
    var toDictionary: [String:Any]{
        let booksArray = books.map{$0.toDictionary}
        let dict: [String:Any] = ["id":id,"name":name,"books":booksArray]
        return dict
    }
    static var id : Int = 0
}
struct Book {
    let title:String
    let author: String
    var toDictionary: [String:Any]{
        let dict: [String:Any] = ["title":title,"author": author]
        return dict
    }
}
