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
