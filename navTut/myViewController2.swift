import UIKit

var currentShelfNum: Int!
class myViewController2: UIViewController,UITableViewDelegate, UITableViewDataSource {

    var taskMgr: TaskManager = TaskManager()
    @IBOutlet var tblTasks: UITableView!
    var cellCurrentIndex = -1
    
    //to track which library is being viewed:
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        //tblTasks.reloadData()
        print("back to second view: ")
        
        for eachShelf in currentLib.shelves {
            var label = "Shelf "
            label = label + String(eachShelf.shelfNum)
            var bookCount = String(eachShelf.numBooks)
            bookCount = bookCount + " book(s)"
            callTaskManager(label, desc2: bookCount)
        }
        println(tblTasks.numberOfRowsInSection(0))
        tblTasks.reloadData()
        println(tblTasks.numberOfRowsInSection(0))
        //check if num cells exceeds numShelves:
        if (tblTasks.numberOfSections()>0) {
            var i = 0
            while ((tblTasks.numberOfRowsInSection(0)>currentLib.numShelves)&&(i<currentLib.numShelves)) {
                print(tblTasks.numberOfRowsInSection(0))
                print(" ")
                println(currentLib.numShelves)
                taskMgr.tasks.removeAtIndex(0)
                i = i + 1
            }
            println("Escaped the loop")
        }
        cellCurrentIndex = -1
    }
    //if cell is clicked:
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        println(tableView.cellForRowAtIndexPath(indexPath).textLabel.text)
        cellCurrentIndex = indexPath.row
    }
    
    //so I can ask a different viewController to call this class's:
    func callTaskManager(name2:String, desc2:String) {
        taskMgr.addTask(name2, desc: desc2)
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return taskMgr.tasks.count
    }
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Test")
        print("indexPath.row ")
        println(indexPath.row)
        
        //to avoid out of index, use the if-method here:
        if (indexPath.row < currentLib.numShelves) {
            cell.textLabel.text = taskMgr.tasks[indexPath.row].name
            cell.detailTextLabel.text = taskMgr.tasks[indexPath.row].desc
        }
        return cell
    }
    
    @IBAction func toView3Pressed(sender : AnyObject) {
        if (cellCurrentIndex == -1) {
            var alert: UIAlertView = UIAlertView()
            alert.title = ""
            alert.message = "Select a shelf first"
            alert.addButtonWithTitle("Ok")
            alert.show()
        }
        else {
            let view3 = self.storyboard.instantiateViewControllerWithIdentifier("view3") as myViewController3
            self.navigationController.pushViewController(view3, animated: true)
            
            //add the cells:
            let currentShelf = currentLib.shelves[cellCurrentIndex]
            currentShelfNum = cellCurrentIndex
            /*for eachBook in currentShelf.books {
                var title = eachBook.title
                if (eachBook.unRead) {
                    view3.callTaskManager(title, desc2: "Unread")
                }
                else {
                    view3.callTaskManager(title, desc2: "Read")
                }
            } */
            view3.currentLib = currentLib
            view3.currentShelf = currentShelf
        }
    }
    

}
