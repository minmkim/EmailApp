//
//  SettingsViewController.swift
//  EmailApp
//
//  Created by Min Kim on 11/3/17.
//  Copyright © 2017 Min Kim. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
  
  @IBOutlet weak var smtpHostField: UITextField!
  @IBOutlet weak var smtpPortField: UITextField!
  @IBOutlet weak var usernameField: UITextField!
  @IBOutlet weak var passwordField: UITextField!
  
  var receivedData: SMTPLogIn?
  var smtpLoginInfo = SMTPLogIn()
  
  @IBAction func testButtonPress(_ sender: Any) {
    let smtpSession = MCOSMTPSession()
    smtpSession.hostname = smtpHostField.text
    smtpSession.username = usernameField.text
    smtpSession.password = passwordField.text
    smtpSession.port = UInt32(Int(smtpPortField.text!)!)
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
    builder.header.to = [MCOAddress(displayName: "", mailbox: usernameField.text)]
    builder.header.from = MCOAddress(displayName: "", mailbox: usernameField.text)
    builder.header.subject = "Test"
    builder.htmlBody = "Test"
    
    let rfc822Data = builder.data()
    let sendOperation = smtpSession.sendOperation(with: rfc822Data!)
    sendOperation?.start { (error) -> Void in
      if (error != nil) {
        let alertController = UIAlertController(title: "Error!", message: "Error: \(error)", preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
          print("OK")
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
        
        NSLog("Error sending email: \(error)")
      } else {
        NSLog("Successfully sent email!")
        
        let alertController = UIAlertController(title: "Successful!", message: "SMTP and Login are valid", preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
          print("OK")
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
      }
    }
  }
  
  @IBAction func saveButtonPress(_ sender: Any) {
    smtpLoginInfo = SMTPLogIn(host: smtpHostField.text, port: smtpPortField.text, username: usernameField.text, password: passwordField.text)
    print("true")
    performSegue(withIdentifier: "unwindSettingsSegue", sender: self)
  }
  
  @IBAction func cancelButtonPress(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    if let currentData = receivedData {
      smtpHostField.text = currentData.host
      smtpPortField.text = currentData.port
      usernameField.text = currentData.username
      passwordField.text = currentData.password
    }
    // Do any additional setup after loading the view.
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
