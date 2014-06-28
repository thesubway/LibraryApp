import UIKit

    var bookWasAdded = false
class myViewController3: UIViewController,UITableViewDelegate, UITableViewDataSource {
    var taskMgr: TaskManager = TaskManager()
    @IBOutlet var tblTasks: UITableView!
    var cellCurrentIndex = -1
    
    var currentLib: Library!
    var currentShelf: Shelf!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        for eachBook in currentShelf.books {
            var title = eachBook.title
            if (eachBook.unRead) {
                callTaskManager(title, desc2: "Unread")
            }
            else {
                callTaskManager(title, desc2: "Read")
            }
        }
        tblTasks.reloadData()
        //check if num cells exceeds numShelves:
        if (tblTasks.numberOfSections()>0) {
            var i = 0
            if (bookWasAdded == true) {
                println("bookWasAdded")
                i = i + 1
                bookWasAdded = false
            }
            else {
                println("NO book added")
            }
            print("currentShelf.numBooks ")
            println(currentShelf.numBooks)
            while ((tblTasks.numberOfRowsInSection(0)>currentShelf.numBooks)&&(i<currentShelf.numBooks)) {
                print(tblTasks.numberOfRowsInSection(0))
                print(" ")
                println(currentShelf.numBooks)
                println(taskMgr.tasks.count)
                taskMgr.tasks.removeAtIndex(0)
                i = i + 1
            }
            println("Escaped the loop")
        }
        cellCurrentIndex = -1
    }
    
    //if cell is clicked:
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        println(tableView.cellForRowAtIndexPath(indexPath).text)
        cellCurrentIndex = indexPath.row
    }
    
    func callTaskManager(name2:String, desc2:String) {
        taskMgr.addTask(name2, desc: desc2)
    }
    
    //DELETE (swipe):
    func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
        //provides us with delete functionality:
        if (editingStyle == UITableViewCellEditingStyle.Delete){
            //so if they tap the delete button:
            taskMgr.tasks.removeAtIndex(indexPath.row)
            //will go to tasks, find index, and remove item at index.
            //now to make sure book knows it's deleted:

            currentShelf.books[indexPath.row].unshelf(currentShelf.shelfNum)
            //but item still exists at tableview, so:
            tblTasks.reloadData()
            
        }
    }
    
    //READ:
    @IBAction func ReadPressed(sender : AnyObject) {
        if (cellCurrentIndex == -1) {
            var alert: UIAlertView = UIAlertView()
            alert.title = ""
            alert.message = "Select a book first"
            alert.addButtonWithTitle("Ok")
            alert.show()
        }
        else {
            currentShelf.books[cellCurrentIndex].unRead = false
            var alert: UIAlertView = UIAlertView()
            alert.title = ""
            alert.message = "Book marked as read. Moving to edit page."
            alert.addButtonWithTitle("Ok")
            alert.show()
            let view5 = self.storyboard.instantiateViewControllerWithIdentifier("view5") as myViewController5
            view5.cellCurrentIndex = cellCurrentIndex
            self.navigationController.pushViewController(view5, animated: true)
        }
    }
    
    //UPDATE:
    @IBAction func EditPressed(sender : UIButton) {
        if (cellCurrentIndex == -1) {
            var alert: UIAlertView = UIAlertView()
            alert.title = ""
            alert.message = "Select a book first"
            alert.addButtonWithTitle("Ok")
            alert.show()
        }
        else {
            let view5 = self.storyboard.instantiateViewControllerWithIdentifier("view5") as myViewController5
            view5.cellCurrentIndex = cellCurrentIndex
            self.navigationController.pushViewController(view5, animated: true)
        }
    }
    
    //ADD is not here, but is included in the main.storyboard
    
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return taskMgr.tasks.count
    }
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Test")
        println(currentShelf.numBooks)
        println()
        print("indexPath.row ")
        println(indexPath.row)
        print("taskMgr.tasks size: ")
        println(taskMgr.tasks.count)
        if (indexPath.row < currentShelf.numBooks) {
            cell.text = taskMgr.tasks[indexPath.row].name
            cell.detailTextLabel.text = taskMgr.tasks[indexPath.row].desc
        }
        return cell
    }
}
