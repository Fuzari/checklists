//
//  ViewController.swift
//  Checklists
//
//  Created by Fuzari on 27/04/2019.
//  Copyright © 2019 Fuzari. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController, AddItemViewControllerDelegate {
    
//  Protocol's function of adding an item
    func itemDetailViewController(_ controller: ItemDetailV, didFinishAdding item: ChecklistItem) {
        let newRowIndex = checklist?.items.count
        checklist?.items.append(item)
        
        let indexPath = IndexPath(row: newRowIndex!, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        navigationController?.popViewController(animated: true)
    }
    
    func itemDetailViewControllerDidCancel(_ controller: ItemDetailV) {
        navigationController?.popViewController(animated: true)
    }
    
//  Protocol's function of editing an item
    func itemDetailViewController(_ controller: ItemDetailV, didFinishEditing item: ChecklistItem) {
        if let index = checklist?.items.index(of: item) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                configureText(for: cell, with: item)
            }
        }
        navigationController?.popViewController(animated: true)
    }
    
    var checklist: Checklist?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setting the title of the screen
        title = checklist?.name
    }

//  This function counts how much rows need to display at storyboard
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (checklist?.items.count)!
    }

//  This function places data to cells at tableview
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
        let item = checklist?.items[indexPath.row]
        
        configureText(for: cell, with: item!)
        configureCheckmark(for: cell, with: item!)
        
        return cell
    }

//  This function places a checkmarks to cells after tap on it
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) {
            let item = checklist?.items[indexPath.row]
            item?.toggleChecked()
            configureCheckmark(for: cell, with: item!)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }

//  This function deletes items from the tableview
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {
        checklist?.items.remove(at: indexPath.row)
        
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
 
//  This function decides place checkmark or not
    func configureCheckmark(for cell: UITableViewCell, with item: ChecklistItem){
        let label = cell.viewWithTag(1001) as! UILabel
        if item.checked{
            label.text = "√"
            label.textColor = view.tintColor
        } else{
            label.text = ""
        }
    }

//  This function is to place text to label
    func configureText(for cell: UITableViewCell, with item: ChecklistItem){
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = item.text
    }
    
// This function provides possibility to decide in which state call the ItemDetailV scene
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItem"{
            let controller = segue.destination as! ItemDetailV
            controller.delegate = self
        } else if segue.identifier == "EditItem"{
            let controller = segue.destination as! ItemDetailV
            controller.delegate = self
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                controller.itemToEdit = checklist?.items[indexPath.row]
            }
        }
    }
}
