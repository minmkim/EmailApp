//
//  SendInformationViewController.swift
//  EmailApp
//
//  Created by Min Kim on 11/3/17.
//  Copyright © 2017 Min Kim. All rights reserved.
//

import UIKit

class SendInformationViewController: UIViewController, UITextViewDelegate {
  
  var emailList = [String]()
  var subjectList = [String]()
  var smtpUserInfo = SMTPLogIn()
  
  @IBOutlet weak var ccCountLabel: UILabel!
  @IBOutlet weak var bccCountLabel: UILabel!
  @IBOutlet weak var toCountLabel: UILabel!
  
  @IBOutlet weak var emailBodyView: UITextView!
  @IBOutlet weak var toView: UITextView!
  @IBOutlet weak var ccView: UITextView!
  @IBOutlet weak var bccView: UITextView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    emailBodyView.delegate = self
    emailBodyView.layer.borderWidth = 0.5
    emailBodyView.layer.borderColor = UIColor.lightGray.cgColor
    toView.layer.borderWidth = 0.5
    toView.layer.borderColor = UIColor.lightGray.cgColor
    ccView.layer.borderWidth = 0.5
    ccView.layer.borderColor = UIColor.lightGray.cgColor
    bccView.layer.borderWidth = 0.5
    bccView.layer.borderColor = UIColor.lightGray.cgColor
    for number in 0..<emailList.count {
      emailBodyView.text! += "Subject \(number):\n\(subjectList[number])\n\nBody \(number):\n\(emailList[number])\n\n"
    }
    
  }
  
  @IBAction func sendButtonPress(_ sender: Any) {
    print("button")
    //print(subjectList)
    //print(emailList)
    var listOfToEmails = [String]()
    listOfToEmails = toView.text.components(separatedBy: .newlines)
    
    //check to make sure to list == email list == subjectlist
    if emailList.count == subjectList.count {
      print("email = subject count")
    } else {
      print("email != subject count")
    }
    if listOfToEmails.count == emailList.count {
      print("To emails = email count")
    } else {
      print("To emails != email count")
    }
    
    let ccList = ccView.text.components(separatedBy: .newlines).count
    let bccList = bccView.text.components(separatedBy: .newlines).count

 /*   for number in 0...(listOfToEmails.count - 1) {
      print("email list \(emailList)")
      print("listOfToEmails \(listOfToEmails)")
      print("subjectList \(subjectList)")
      print(number)
      print(smtpUserInfo.host!)
      print(smtpUserInfo.username!)
      print(smtpUserInfo.password!)
      print(UInt32(Int(smtpUserInfo.port!)!))
      let smtpSession = MCOSMTPSession()
      smtpSession.hostname = smtpUserInfo.host!
      smtpSession.username = smtpUserInfo.username!
      smtpSession.password = smtpUserInfo.password!
      smtpSession.port = UInt32(Int(smtpUserInfo.port!)!)
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
      builder.header.to = [MCOAddress(displayName: "", mailbox: listOfToEmails[number])]
      builder.header.from = MCOAddress(displayName: "", mailbox: smtpUserInfo.username!)
      builder.header.subject = subjectList[number]
      let attributedString = NSMutableAttributedString(string: emailList[number])
      let emailHTML = convertToHTML(string: attributedString)
      builder.htmlBody = emailHTML
      
      let rfc822Data = builder.data()
      let sendOperation = smtpSession.sendOperation(with: rfc822Data!)
      sendOperation?.start { (error) -> Void in
        if (error != nil) {
          NSLog("Error sending email: \(error)")
        } else {
          NSLog("Successfully sent email!")
        }
      }
      
    }*/
  }
    
    
    
    /*
      let alertController = UIAlertController(title: "Error!", message: "Not all columns have the same number of items", preferredStyle: UIAlertControllerStyle.alert)
      let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
        print("OK")
      }
      alertController.addAction(okAction)
      self.present(alertController, animated: true, completion: nil)
    }*/
    
  //}
  
  func convertToHTML(string: NSAttributedString) -> String {
    
    let attrStr = string
    let documentAttributes = [NSAttributedString.DocumentAttributeKey.documentType: NSAttributedString.DocumentType.html]
    do {
      let htmlData = try attrStr.data(from: NSMakeRange(0, attrStr.length), documentAttributes:documentAttributes)
      if let htmlString = String(data:htmlData, encoding:String.Encoding.utf8) {
        return htmlString
        // print(htmlString)
      }
    }
    catch {
      print("error creating HTML from Attributed String")
      
    }
    return "Error"
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
}
