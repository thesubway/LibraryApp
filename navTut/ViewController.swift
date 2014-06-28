//
//  ViewController.swift
//  LibraryApp
//
//  Created by Daniel Hoang on 6/24/14.
//  Copyright (c) 2014 Daniel Hoang. All rights reserved.
//

import UIKit

    var currentLib: Library!
class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    var taskMgr: TaskManager = TaskManager()
    @IBOutlet var tblTasks: UITableView!
    var cellCurrentIndex = -1
    var libraries: Library[] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Adding some sample books and libraries:
        var collegeLibrary = Library(name:"College Library",numShelves: 4)
        var publicLibrary = Library(name:"Public Library",numShelves: 5)
        var privateLibrary = Library(name:"Private Library",numShelves:1)
        let bookOnSwift = Book(libraryName: collegeLibrary, title: "Book On Swift")
        bookOnSwift.enshelf(0)
        let bookObjC = Book(libraryName: collegeLibrary,title: "Objective C")
        bookObjC.enshelf(0)
        let bookFlow = Book(libraryName: publicLibrary,title: "Flow")
        bookFlow.enshelf(1)
        libraries.append(collegeLibrary)
        libraries.append(publicLibrary)
        libraries.append(privateLibrary)
        for eachLibrary in libraries {
            var shelfNum = String(eachLibrary.numShelves)
            shelfNum = shelfNum + " shelf(s)"
            taskMgr.addTask(eachLibrary.name, desc: shelfNum)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Returning to view
    //so to update the list:
    override func viewWillAppear(animated: Bool) {
        //when view is about to appear:
        tblTasks.reloadData()
        print("Back to first view: ")
        println(libraries[1].shelves[1].numBooks)
        cellCurrentIndex = -1
    }
    
    //if cell is clicked:
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        println(tableView.cellForRowAtIndexPath(indexPath).text)
        cellCurrentIndex = indexPath.row
    }
    
    //this enters the library:
    @IBAction func toView2Pressed(sender : AnyObject) {
        //first check the recently clicked cell:
        if (cellCurrentIndex == -1) {
            var alert: UIAlertView = UIAlertView()
            alert.title = ""
            alert.message = "Select a library first"
            alert.addButtonWithTitle("Ok")
            alert.show()
        }
        else {
            let view2 = self.storyboard.instantiateViewControllerWithIdentifier("view2") as myViewController2
            self.navigationController.pushViewController(view2, animated: true)
            
            currentLib = libraries[cellCurrentIndex]
            //tell view2 to remember what library it's in:
            //view2.currentLibIndex = cellCurrentIndex
            
            //add the cells:
            /*for eachShelf in currentLib.shelves {
                var label = "Shelf "
                label = label + String(eachShelf.shelfNum)
                var bookCount = String(eachShelf.numBooks)
                bookCount = bookCount + " book(s)"
                view2.callTaskManager(label, desc2: bookCount)
            } */
        }
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return taskMgr.tasks.count
    }
    //three times this function gets executed,
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Test")
        
        //extract the data we want
        cell.text = taskMgr.tasks[indexPath.row].name
        cell.detailTextLabel.text = taskMgr.tasks[indexPath.row].desc
        
        return cell
    }

}

