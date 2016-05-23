//
//  TouchViewController.swift
//  TouchLogin
//
//  Created by Christopher Yung on 2/13/16.
//  Copyright © 2016 TouchLogin. All rights reserved.
//

import UIKit
import LocalAuthentication
import Alamofire

class TouchViewController: UIViewController {
  
  @IBOutlet weak var statusLabel: UILabel!
  @IBOutlet weak var nameForm: UITextField!
  @IBOutlet weak var emailForm: UITextField!
  @IBOutlet weak var authorizeButton: UIButton!
  @IBOutlet weak var updateButton: UIButton!
  var UID : String = UIDevice.currentDevice().identifierForVendor!.UUIDString
  var authorized : Bool = false
	var identifier: Int = 0
	
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.statusLabel.text = "Unauthorized"
//    loadInfo()
    authorizeButton.backgroundColor = UIColor.grayColor()
    authorizeButton.layer.cornerRadius = 5
    authorizeButton.layer.borderWidth = 1
    authorizeButton.layer.borderColor = UIColor.blackColor().CGColor
    authorizeButton.titleEdgeInsets=UIEdgeInsetsMake(0, 5, 0, 5);
    authorizeButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
    print("UID=\(UID)")
  }
  
	func authenticateUser(identifier:Int){
//    if (authorized) {
//      self.sendToServer()
//      return
//    }

	// Get the local authentication context.
	let context = LAContext()
	
	// Declare a NSError variable.
	var error: NSError?
	
	// Set the reason string that will appear on the authentication alert.
	let reasonString = "Authentication is needed to access your notes."
	
	// Check if the device can evaluate the policy.
	if context.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error: &error) {
		[context .evaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, localizedReason: reasonString, reply: { (success: Bool, evalPolicyError: NSError?) -> Void in
			
			if success {
				let headers = [
						"Content-Type": "application/json",
					]
					
					let parameters = [
						"UID": self.UID,
						"identifier": String(identifier),
						"username": "Vanya"
					]
					
					print("Successfully sent data to server")
					
					let url = "https://touch-login.appspot.com/_ah/api/touchloginAPI/v1/AuthenticationReply"
					
					Alamofire.request(.POST, url, headers: headers, parameters: parameters as [String : String], encoding: .JSON)
						.response { response in
							//print(response)
				}

			}
			else{
				// If authentication failed then show a message to the console with a short description.
				// In case that the error is a user fallback, then show the password alert view.
				print(evalPolicyError?.localizedDescription)
				
				switch evalPolicyError!.code {
					
				case LAError.SystemCancel.rawValue:
					print("Authentication was cancelled by the system")
					
				case LAError.UserCancel.rawValue:
					print("Authentication was cancelled by the user")
					
				case LAError.UserFallback.rawValue:
					print("User selected to enter custom password")
					
				default:
					print("Authentication failed")
				}
			}
			
		})]
	}
	else{
		// If the security policy cannot be evaluated then show a short message depending on the error.
		switch error!.code{
			
		case LAError.TouchIDNotEnrolled.rawValue:
			print("TouchID is not enrolled")
			
		case LAError.PasscodeNotSet.rawValue:
			print("A passcode has not been set")
			
		default:
			// The LAError.TouchIDNotAvailable case.
			print("TouchID not available")
		}
		
		// Optionally the error description can be displayed on the console.
		print(error?.localizedDescription)

	}
}
//    let touchIDManager = TouchIDManager()
//
//    touchIDManager.authenticateUser(success: { () -> () in
//      NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
//        self.authorized = true
//        self.statusLabel.text = "AUTHORIZED"
//      })
//      }, failure: { (evaluationError: NSError) -> () in
//        switch evaluationError.code {
//        case LAError.SystemCancel.rawValue:
//          print("Authentication cancelled by the system")
//          self.statusLabel.text = "Unauthorized"
//        case LAError.UserCancel.rawValue:
//          print("Authentication cancelled by the user")
//          self.statusLabel.text = "Unauthorized"
//        case LAError.UserFallback.rawValue:
//          print("User wants to use a password")
//          self.statusLabel.text = "Password not supported"
//        case LAError.TouchIDNotEnrolled.rawValue:
//          print("TouchID not enrolled")
//          self.statusLabel.text = "TouchID not supported"
//        case LAError.PasscodeNotSet.rawValue:
//          print("Passcode not set")
//          self.statusLabel.text = "Unauthorized"
//        default:
//          print("Authentication failed")
//          self.statusLabel.text = "Authentication failed"
//        }
//    })
  
 //	func replyToServer(identifier: Int) {
//		let headers = [
//		  "Content-Type": "application/json",
//		]
//		
//		let parameters = [
//		  "UID": UID,
//		  "identifier": String(identifier),
//		  "username": "Vanya"
//		]
//		
//		print("Successfully sent data to server")
//		
//		let url = "https://touch-login.appspot.com/_ah/api/touchloginAPI/v1/AuthenticationReply"
//		
//		Alamofire.request(.POST, url, headers: headers, parameters: parameters as [String : String], encoding: .JSON)
//		  .response { response in
//			//print(response)
//		}
//  }
//	func application(application: UIApplication, didReceiveRemoteNotification notificationInfo: [NSObject : AnyObject]) {
//		// display the userInfo
//		print(notificationInfo["aps"])
//		authenticateUser()
//		replyToServer(notificationInfo["aps"]!["identifier"])
//		}
}

	

