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
    print(subjectList)
    print(emailList)
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
