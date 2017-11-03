//
//  SMTPLogIn.swift
//  EmailApp
//
//  Created by Min Kim on 11/3/17.
//  Copyright © 2017 Min Kim. All rights reserved.
//

import Foundation

struct SMTPLogIn: Codable {
  var host: String?
  var port: String?
  var username: String?
  var password: String?
}
