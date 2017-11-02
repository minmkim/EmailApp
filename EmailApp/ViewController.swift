//
//  ViewController.swift
//  EmailApp
//
//  Created by Min Kim on 10/24/17.
//  Copyright © 2017 Min Kim. All rights reserved.
//

import UIKit
import MobileCoreServices


class ViewController: UIViewController, UIDropInteractionDelegate, UITextViewDelegate, UITextDropDelegate {
  
  @IBOutlet weak var emailBodyField: UITextView!
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var tableOfVariables: UITableView!
  @IBOutlet weak var toField: UITextField!
  @IBOutlet weak var ccField: UITextField!
  @IBOutlet weak var bccField: UITextField!
  @IBOutlet weak var subjectField: UITextField!
  
  let variablesForEmail = ["[[Name]]", "[[First Name]]", "[[Last Name]]", "[[Date]]", "[[My Name]]", "[[Chairman Lee]]", "[[Variable 1]]", "[[Variable 2]]", "[[Variable 3]]", "[[Variable 4]]", "[[Variable 5]]", "[[Variable 6]]", "[[Variable 7]]", "[[Variable 8]]", "[[Variable 9]]", "[[Variable 10]]"]
  var usedList = [String]()
  var shownList = [String]()
  var originIndexPath: Int?
  var initialSubjectText = ""
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    tableOfVariables.delegate = self
    tableOfVariables.dataSource = self
    view.addInteraction(UIDropInteraction(delegate: self))
    registerForKeyboardNotifications()
    tableOfVariables.separatorStyle = UITableViewCellSeparatorStyle.none
    shownList = variablesForEmail
    let dropInteraction = UIDropInteraction(delegate:self)
    emailBodyField.addInteraction(dropInteraction)
    emailBodyField.textDropDelegate = self
    subjectField.textDropDelegate = self
    emailBodyField.allowsEditingTextAttributes = true
    emailBodyField.layer.borderWidth = 0.5
    emailBodyField.layer.borderColor = UIColor.lightGray.cgColor
  }
  
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func registerForKeyboardNotifications() {
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(_:)), name: .UIKeyboardDidShow, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(_:)), name: .UIKeyboardWillHide, object: nil)
  }
  
  @objc func keyboardWasShown(_ notificiation: NSNotification) {
    if let keyboardSize = (notificiation.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
      let window = self.view.window?.frame {
      // We're not just minusing the kb height from the view height because
      // the view could already have been resized for the keyboard before
      self.view.frame = CGRect(x: self.view.frame.origin.x,
                               y: self.view.frame.origin.y,
                               width: self.view.frame.width,
                               height: window.origin.y + window.height - keyboardSize.height)
    } else {
      debugPrint("We're showing the keyboard and either the keyboard size or window is nil: panic widely.")
    }
  }
  
  
  @objc func keyboardWillBeHidden(_ notification: NSNotification) {
    if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
      let viewHeight = self.view.frame.height
      self.view.frame = CGRect(x: self.view.frame.origin.x,
                               y: self.view.frame.origin.y,
                               width: self.view.frame.width,
                               height: viewHeight + keyboardSize.height)
    } else {
      debugPrint("We're about to hide the keyboard and the keyboard size is nil. Now is the rapture.")
    }
  }
  
  
  func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
    return true
  }
  
  func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
    return UIDropProposal(operation: .copy)
  }
  
  func textDroppableView(_ textDroppableView: UIView & UITextDroppable, dropSessionDidEnter session: UIDropSession) {
    if let textInField = subjectField.text {
      initialSubjectText = textInField
    }
    
  }
  
  func textDroppableView(_ textDroppableView: UIView & UITextDroppable, dropSessionDidEnd session: UIDropSession) {
    if initialSubjectText.count < subjectField.text!.count { // if dropped into subjectField
      print(initialSubjectText)
      let newVariable = String(subjectField.text!.suffix(subjectField.text!.count - initialSubjectText.count))
      usedList.append(newVariable)
      print("Ended")
    }
  }
  
  func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
    print("Drop Session")
    session.loadObjects(ofClass: NSString.self) { stringItems in
      let strings = stringItems as! [String]
      for string in strings {
        self.emailBodyField.text.append(string)
        self.usedList.append(self.shownList[self.originIndexPath!])
        print(self.usedList)
      }
      print(self.emailBodyField.attributedText)
    }
    
    
    // Perform additional UI updates as needed.
    //  let dropLocation = session.location(in: view)
    //  updateLayers(forDropLocation: dropLocation)
  }
  
  
  
}




