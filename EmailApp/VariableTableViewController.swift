//
//  VariableTableViewController.swift
//  EmailApp
//
//  Created by Min Kim on 11/1/17.
//  Copyright © 2017 Min Kim. All rights reserved.
//

import UIKit
import MobileCoreServices

extension ViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDragDelegate {
  func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
    
    let string = variablesForEmail[indexPath.row]
    guard let data = (string).data(using: .utf8) else { return [] }
    let itemProvider = NSItemProvider(item: data as NSData, typeIdentifier: kUTTypePlainText as String)
    let item = UIDragItem(itemProvider: itemProvider)
    //item.localObject = string
    
    originIndexPath = indexPath.row
    print("Start Drag")
    return [UIDragItem(itemProvider: itemProvider)]
    
  }
  
  // func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
  //     return 30
  // }
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    tableView.dragDelegate = self
    tableView.dragInteractionEnabled = true
    return variablesForEmail.count
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    cell.selectionStyle = UITableViewCellSelectionStyle.none
    cell.layer.cornerRadius = 12
    cell.backgroundColor = UIColor(red: 1, green: 0.427, blue: 0.397, alpha: 1)
    
    cell.layer.borderWidth = CGFloat(5)
    cell.layer.borderColor = tableView.backgroundColor?.cgColor
    
    
    let textLabel = cell.textLabel
    textLabel?.textColor = UIColor.white
    
    textLabel?.text = String(shownList[indexPath.row].dropFirst(2).dropLast(2))
    return cell
  }
  
  func convertStringToHTML (Body: String) {
    
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let controller = segue.destination as! InformationViewController
    usedList = Array(Set(usedList)) // remove duplicates
    
    for item in usedList { //remove any variables that were not used in email body or subject (dropped in but removed)
      if (emailBodyField.text.range(of: item) != nil) || (subjectField.text?.range(of: item) != nil) {
        //variable was used in email body or subject
      } else {
        usedList = usedList.filter{$0 != item}
      }
    }
    
    controller.listToUse = usedList
    controller.emailBodyText = emailBodyField.text
    print(subjectField.text)
    controller.subjectText = subjectField.text
    
    /*   let smtpSession = MCOSMTPSession()
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
     builder.htmlBody = emailBodyField.text
     
     let rfc822Data = builder.data()
     let sendOperation = smtpSession.sendOperation(with: rfc822Data!)
     sendOperation?.start { (error) -> Void in
     if (error != nil) {
     NSLog("Error sending email: \(error)")
     } else {
     NSLog("Successfully sent email!")
     }
     } */
    /*
     var dataImage: NSData?
     dataImage = UIImageJPEGRepresentation(image, 0.6)!
     var attachment = MCOAttachment()
     attachment.mimeType =  "image/jpg"
     attachment.filename = "image.jpg"
     attachment.data = dataImage
     builder.addAttachment(attachment)
     */
  }
  
  
}
