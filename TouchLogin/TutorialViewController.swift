//
//  TutorialViewController.swift
//  TouchLogin
//
//  Created by Ivan on 6/25/16.
//  Copyright © 2016 TouchLogin. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController, BWWalkthroughViewControllerDelegate {

	override func viewDidAppear(animated: Bool) {
		
		let stb = UIStoryboard(name: "Main", bundle: nil)
		let walkthrough = stb.instantiateViewControllerWithIdentifier("tutorialContainer") as! BWWalkthroughViewController
		let page_one = stb.instantiateViewControllerWithIdentifier("tutorialPage1")
		let page_two = stb.instantiateViewControllerWithIdentifier("tutorialPage2")
		let page_three = stb.instantiateViewControllerWithIdentifier("tutorialPage3")
        let page_four = stb.instantiateViewControllerWithIdentifier("tutorialPage4")
        let page_five = stb.instantiateViewControllerWithIdentifier("tutorialPage5")
        let page_six = stb.instantiateViewControllerWithIdentifier("tutorialPage6")
		
		// Attach the pages to the master
		walkthrough.delegate = self
		walkthrough.addViewController(page_one)
		walkthrough.addViewController(page_two)
		walkthrough.addViewController(page_three)
        walkthrough.addViewController(page_four)
        walkthrough.addViewController(page_five)
        walkthrough.addViewController(page_six)
		
		self.presentViewController(walkthrough, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
