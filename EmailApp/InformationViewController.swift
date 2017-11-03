//
//  InformationViewController.swift
//  EmailApp
//
//  Created by Min Kim on 10/24/17.
//  Copyright © 2017 Min Kim. All rights reserved.
//

import UIKit

class InformationViewController: UIViewController, UITextViewDelegate {
  
  @IBOutlet weak var emailBodyView: UITextView!
  
  
  //@IBOutlet weak var subjectField: UITextField!
  
  @IBOutlet weak var titleLabel1: UILabel!
  @IBOutlet weak var textLabel1: UITextView!
  @IBOutlet weak var countLabel1: UILabel!
  
  @IBOutlet weak var titleLabel2: UILabel!
  @IBOutlet weak var textLabel2: UITextView!
  @IBOutlet weak var countLabel2: UILabel!
  
  @IBOutlet weak var titleLabel3: UILabel!
  @IBOutlet weak var textLabel3: UITextView!
  @IBOutlet weak var countLabel3: UILabel!
  
  @IBOutlet weak var titleLabel4: UILabel!
  @IBOutlet weak var textLabel4: UITextView!
  @IBOutlet weak var countLabel4: UILabel!
  
  @IBOutlet weak var titleLabel5: UILabel!
  @IBOutlet weak var textLabel5: UITextView!
  @IBOutlet weak var countLabel5: UILabel!
  
  @IBOutlet weak var titleLabel6: UILabel!
  @IBOutlet weak var textLabel6: UITextView!
  @IBOutlet weak var countLabel6: UILabel!
  
  @IBOutlet weak var titleLabel7: UILabel!
  @IBOutlet weak var textLabel7: UITextView!
  @IBOutlet weak var countLabel7: UILabel!
  
  @IBOutlet weak var titleLabel8: UILabel!
  @IBOutlet weak var textLabel8: UITextView!
  @IBOutlet weak var countLabel8: UILabel!
  
  @IBOutlet weak var titleLabel9: UILabel!
  @IBOutlet weak var textLabel9: UITextView!
  @IBOutlet weak var countLabel9: UILabel!
  
  @IBOutlet weak var titleLabel10: UILabel!
  @IBOutlet weak var textLabel10: UITextView!
  @IBOutlet weak var countLabel10: UILabel!
  
  @IBOutlet weak var titleLabel11: UILabel!
  @IBOutlet weak var textLabel11: UITextView!
  @IBOutlet weak var countLabel11: UILabel!
  
  @IBOutlet weak var titleLabel12: UILabel!
  @IBOutlet weak var textLabel12: UITextView!
  @IBOutlet weak var countLabel12: UILabel!
  
  @IBOutlet weak var titleLabel13: UILabel!
  @IBOutlet weak var textLabel13: UITextView!
  @IBOutlet weak var countLabel13: UILabel!
  
  @IBOutlet weak var titleLabel14: UILabel!
  @IBOutlet weak var textLabel14: UITextView!
  @IBOutlet weak var countLabel14: UILabel!
  
  @IBOutlet weak var titleLabel15: UILabel!
  @IBOutlet weak var textLabel15: UITextView!
  @IBOutlet weak var countLabel15: UILabel!
  
  @IBOutlet weak var titleLabel16: UILabel!
  @IBOutlet weak var textLabel16: UITextView!
  @IBOutlet weak var countLabel16: UILabel!
  
  
  var listOfTitles = [UILabel]()
  var listOfTextLabel = [UITextView]()
  var listOfcountLabel = [UILabel]()
  var smtpUserInfo = SMTPLogIn()
  
  var listToUse = [String]()
  var emailBodyText: String?
  var subjectText: String?
  var components = [String]()
  var newString = ""
  var newSubject = ""
  var finalEmailList = [String]() // list of email body with all the variables added
  var finalSubjectList = [String]() // list of email subject with all the variables added
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    listOfTitles = [self.titleLabel1, self.titleLabel2, self.titleLabel3, self.titleLabel4, self.titleLabel5, self.titleLabel6, self.titleLabel7, self.titleLabel8, self.titleLabel9, self.titleLabel10, self.titleLabel11, self.titleLabel12, self.titleLabel13, self.titleLabel14, self.titleLabel15, self.titleLabel16]
    listOfTextLabel = [self.textLabel1, self.textLabel2, self.textLabel3, self.textLabel4, self.textLabel5, self.textLabel6, self.textLabel7, self.textLabel8, self.textLabel9, self.textLabel10, self.textLabel11, self.textLabel12, self.textLabel13, self.textLabel14, self.textLabel15, self.textLabel16]
    listOfcountLabel = [self.countLabel1, self.countLabel2, self.countLabel3, self.countLabel4, self.countLabel5, self.countLabel6, self.countLabel7, self.countLabel8, self.countLabel9, self.countLabel10, self.countLabel11, self.countLabel12, self.countLabel13, self.countLabel14, self.countLabel15, self.countLabel16]
//    listToUse.insert("To", at: 0)
//    listToUse.insert("CC", at: 1)
//    listToUse.insert("BCC", at: 2)
    
    if listToUse.count > 0 {
      for number in 0..<listToUse.count {
        listOfTitles[number].text = String(listToUse[number].dropFirst(2).dropLast(2))
      }
    }
    emailBodyView.layer.borderWidth = 0.5
    emailBodyView.layer.borderColor = UIColor.lightGray.cgColor
    for number in 0..<listOfTextLabel.count {
      listOfTextLabel[number].delegate = self
      listOfTextLabel[number].layer.borderWidth = 0.5
      listOfTextLabel[number].layer.borderColor = UIColor.lightGray.cgColor
    }
    
    for number in 1...listOfTextLabel.count {
      if #available(iOS 9.0, *) {
        let item = listOfTextLabel[number-1].inputAssistantItem
        item.leadingBarButtonGroups = [];
        item.trailingBarButtonGroups = [];
      }
    }
    
    for number in listToUse.count..<(listOfTextLabel.count) {
      print("number \(number)")
      listOfTextLabel[number].isHidden = true
      listOfTitles[number].isHidden = true
      listOfcountLabel[number].isHidden = true
    }
    
    emailBodyView.text = "Subject:\n\(subjectText!)\n\nBody:\n\(emailBodyText!)"
    
    
  //  print(subjectText)
  }
  
  @IBAction func testPress(_ sender: Any) {
  //  print(subjectText)
    var counter = -1
    
    components = listOfTextLabel[0].text.components(separatedBy: .newlines) // need to update this based on each component
    var countOfEachVariable = [Int]()
    for number in 0..<listToUse.count {
      countOfEachVariable.append(listOfTextLabel[number].text.components(separatedBy: .newlines).count)
    }
    
    let checkArray = Array(Set(countOfEachVariable))
    if checkArray.count > 1 { //check if all the lists have the same number of items
      let alertController = UIAlertController(title: "Error!", message: "Not all columns have the same number of items", preferredStyle: UIAlertControllerStyle.alert)
      let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
        print("OK")
      }
      alertController.addAction(okAction)
      self.present(alertController, animated: true, completion: nil)
    } else {
      for number in 0..<components.count { // for each email based on count of different items placed
        print("number \(number)")
        newString = emailBodyText!
        newSubject = subjectText!
        var printSubject = ""
        var printString = ""
        var counter = -1
        for item in listToUse { // for number of variables that we need to update in string
          counter += 1
          let newComponent = listOfTextLabel[counter].text.components(separatedBy: .newlines)
          print("list \(listOfTitles[counter].text!)")
          print("newcomponent \(newComponent[number])")
          newString = newString.replacingOccurrences(of: "[[\(listOfTitles[counter].text!)]]", with: newComponent[number])
          print("1 \(newString)")
          printString = newString
        }
        printString = printString.replacingOccurrences(of: "\n", with: "<br>")
        finalEmailList.append(printString)
        var newCounter = -1
        if subjectText!.range(of: "[[") != nil {
          for item in listToUse { // for number of variables that we need to update in string
            newCounter += 1
            let newComponent = listOfTextLabel[newCounter].text.components(separatedBy: .newlines)
            newSubject = newSubject.replacingOccurrences(of: "[[\(listOfTitles[newCounter].text!)]]", with: newComponent[number])
            print("1 \(newSubject)")
            printSubject = newSubject
          }
        } else {
          printSubject = newSubject
        }
        finalSubjectList.append(printSubject)
    //    let emailString = printString
        emailBodyView.text! += "\n\nSubject \(number):\n\(finalSubjectList[number])\n\nBody \(number):\n\(finalEmailList[number])"
        
        
        print("2 \(printString)")
      }
    }
    print("Final \(finalEmailList)\n\n\n\n\n\n\n\n\n\n\n")
    performSegue(withIdentifier: "SendInformationSegue", sender: self)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let controller = segue.destination as! SendInformationViewController
    print("segue")
    print(finalSubjectList)
    print(finalEmailList)
    controller.subjectList = finalSubjectList
    controller.emailList = finalEmailList
    controller.smtpUserInfo = smtpUserInfo
  }
  
  
  //need to make tests to ensure that the email is sent correctly.
  // 1. all count variables are the same
  // 2. preview for email?
  
  func textViewDidChange(_ textView: UITextView) {
    print(listOfTextLabel)
    if listOfTextLabel.count > 0 {
      for number in 1...listOfTextLabel.count {
        components = listOfTextLabel[number-1].text.components(separatedBy: .newlines)
        listOfcountLabel[number-1].text = "Count: \(components.count)"
      }
    }
  }
  
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  /*  let smtpSession = MCOSMTPSession()
   smtpSession.hostname = "smtp.mailplug.co.kr"
   smtpSession.username = "int.law_gb@hwpl.kr"
   smtpSession.password = "intlaw05!@"
   smtpSession.port = 465
   smtpSession.authType = MCOAuthType.saslPlain
   smtpSession.connectionType = MCOConnectionType.TLS
   smtpSession.connectionLogger = {(connectionID, type, data) in
   if data != nil {
   if let string = NSString(data: data!, encoding: String.Encoding.utf8.rawValue){
   NSLog("Connectionlogger: \(string)")
   }
   }
   }
   
   let builder = MCOMessageBuilder()
   builder.header.to = [MCOAddress(displayName: "Nahye", mailbox: "hyehey115@gmail.com")]
   builder.header.from = MCOAddress(displayName: "HWPL", mailbox: "int.law_gb@hwpl.kr")
   builder.header.subject = "TESTING"
   builder.htmlBody = printString
   print(newString)
   
   let rfc822Data = builder.data()
   let sendOperation = smtpSession.sendOperation(with: rfc822Data!)
   sendOperation?.start { (error) -> Void in
   if (error != nil) {
   NSLog("Error sending email: \(error)")
   } else {
   NSLog("Successfully sent email!")
   }
   }*/
  
  
}
