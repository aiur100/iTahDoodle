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
    
    func addItem(item: String){
        items.append(item)
    }
    
    func getItem(element: Int) -> String{
        return items[element]
    }
    
    func itemCount() -> Int {
        return items.count;
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
}
