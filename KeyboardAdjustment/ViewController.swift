import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    var activeField: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidShow:", name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillBeHidden:", name: UIKeyboardWillHideNotification, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        activeField = textField
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        activeField = nil
    }
    
    func keyboardDidShow(notification: NSNotification) {
        let info = notification.userInfo!
        var keyboardRect = info[UIKeyboardFrameBeginUserInfoKey]!.CGRectValue()
        keyboardRect = view.convertRect(keyboardRect, fromView: nil)
        
        let padding = CGFloat(10)
        let contentInsetHeight = keyboardRect.size.height + padding
        
        scrollView.contentInset = UIEdgeInsetsMake(0.0, 0.0, contentInsetHeight, 0.0)
        
        var rect = view.frame
        rect.size.height -= keyboardRect.size.height
        
        if !CGRectContainsPoint(rect, activeField!.frame.origin) {
            scrollView.scrollRectToVisible(activeField!.frame, animated: true)
        }
    }
    
    func keyboardWillBeHidden(notification: NSNotification) {
        scrollView.contentInset = UIEdgeInsetsZero
        scrollView.scrollIndicatorInsets = UIEdgeInsetsZero
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}