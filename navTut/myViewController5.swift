import UIKit

class myViewController5: UIViewController, UITextFieldDelegate {
    //@IBOutlet var txtTask: UITextField!
    @IBOutlet var txtTitle: UITextField!
    //add a mark as unread button, and a mark as read button.
    
    var cellCurrentIndex = -1
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //buttons click:
    @IBAction func EditTitlePressed(sender : UIButton) {
        currentLib.shelves[currentShelfNum].books[cellCurrentIndex].title = txtTitle.text
        txtTitle.text = ""
    }
    @IBAction func MarkUnreadPressed(sender : UIButton) {
        currentLib.shelves[currentShelfNum].books[cellCurrentIndex].unRead = true
    }
    @IBAction func MarkReadPressed(sender : UIButton) {
        currentLib.shelves[currentShelfNum].books[cellCurrentIndex].unRead = false
    }
    
    //IOS Touch Functions
    override func touchesBegan(touches: NSSet!, withEvent event: UIEvent!) {
        //so when i click away, keyboard input should disappear
        self.view.endEditing(true)
    }
    
    //UITextField Delegate
    func textFieldShouldReturn(textField: UITextField!) -> Bool{
        //before returning true, gonna tell textbox to resign its first responder
        textField.resignFirstResponder()
        //in this instance, first responder is gonna be keyboard
        return true
    }
}