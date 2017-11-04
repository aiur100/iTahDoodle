//
//  TodoList.swift
//  iTahDoodle
//
//  Created by The Captain on 11/1/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

import UIKit

class TodoList: NSObject {
    private var items: [String] = []
    private let fileURL: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("todo.list", isDirectory: false);
    
    
    func addItem(item: String){
        items.append(item)
        saveItems()
    }
    
    func saveItems(){
        let itemsAsArray = items as NSArray;
        print(fileURL);
        if !itemsAsArray.write(to: fileURL as URL, atomically: true){
            print("Could not save to-do list")
        }
    }
    
    func deleteItem(element: Int){
        items.remove(at: element)
        print(element)
        saveItems()
        loadItems()
    }
    
    func loadItems(){
        if let itemsArray = NSArray(contentsOf: fileURL as URL) as? [String] {
            items = itemsArray
            print(items.count)
        }
    }
    
    func getItem(element: Int) -> String{
        return items[element]
    }
    
    func itemCount() -> Int {
        return items.count;
    }
    
    override init(){
        super.init()
        loadItems()
    }
    
    
}

extension TodoList: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let item = getItem(element: indexPath.row)
        cell.textLabel!.text = item
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            deleteItem(element: indexPath.row)
            tableView.reloadData()
        }
    }
    
}
