import UIKit

class myViewController4: UIViewController, UITextFieldDelegate {
    //title of the book:
    @IBOutlet var txtTitle: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //button click:
    @IBAction func addBookPressed(sender : UIButton) {
        let view3 = self.storyboard.instantiateViewControllerWithIdentifier("view3") as myViewController3
        view3.callTaskManager(txtTitle.text, desc2: "Unread")
        bookWasAdded = true
        //also, add the book:
        var newBook = Book(libraryName: currentLib, title: txtTitle.text)
        newBook.enshelf(currentShelfNum)
        txtTitle.text = ""
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