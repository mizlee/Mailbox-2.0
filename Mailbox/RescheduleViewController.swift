//
//  RescheduleViewController.swift
//  Mailbox
//
//  Created by Lee Cline on 9/22/14.
//  Copyright (c) 2014 yahoo. All rights reserved.
//

import UIKit

class RescheduleViewController: UIViewController {

    @IBOutlet weak var reschedulePage: UIImageView!
    
    @IBOutlet var tapListener: UITapGestureRecognizer!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func onTap(sender: UITapGestureRecognizer) {
        dismissViewControllerAnimated(true, completion: nil)
}
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
