//
//  MailboxViewController.swift
//  Mailbox
//
//  Created by Lee Cline on 9/16/14.
//  Copyright (c) 2014 yahoo. All rights reserved.
//

import UIKit

class MailboxViewController: UIViewController {
    
    @IBOutlet var panGestureRecognizer: UIPanGestureRecognizer!
    
    @IBOutlet weak var messageContainer: UIView!
    
    @IBOutlet weak var messageOne: UIImageView!
    
    @IBOutlet weak var laterIcon: UIImageView!
    
    @IBOutlet weak var listIcon: UIImageView!
    
    @IBOutlet weak var archiveIcon: UIImageView!
    
    @IBOutlet weak var deleteIcon: UIImageView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var feedView: UIImageView!
    
    @IBOutlet var tapListener: UITapGestureRecognizer!
    
    @IBOutlet weak var reschedulePage: UIImageView!
    
    @IBOutlet weak var dismissButtonLeft: UIButton! //there must be a more elegant way to do this
    
    @IBOutlet weak var listPage: UIImageView!
    
    @IBOutlet weak var dismissButtonRight: UIButton!
    
    @IBOutlet weak var resetButton: UIButton!
    
    var messageOneCenter: CGPoint! //sets location of drag
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize = feedView.image!.size
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onPanMessage(sender: UIPanGestureRecognizer){
        //magic code:
        var point = panGestureRecognizer.locationInView(view)
        var velocity = panGestureRecognizer.velocityInView(view)
        var translation = sender.translationInView(view) //setup for drag and drop relative to finger
        
        if panGestureRecognizer.state == UIGestureRecognizerState.Began {
            //do something at the start of the pan
            println("Gesture began at: \(point)")
            //set color to grey
            messageContainer.backgroundColor = UIColor(red: 214/255, green: 214/255, blue: 214/255, alpha: 1.0)
        }
        else if panGestureRecognizer.state == UIGestureRecognizerState.Changed {
            //do something during pan
            //drag the message
            messageOne.frame.origin.x = translation.x
            println("Gesture changed at: \(point)")
            
            //if dragging left a little
            if messageOne.frame.origin.x < 0 && messageOne.frame.origin.x > -60 {
                //set color to grey
                messageContainer.backgroundColor = UIColor(red: 214/255, green: 214/255, blue: 214/255, alpha: 1.0)
                //set start opacity of later icon
                laterIcon.alpha = 0.5
            }
                
            //if dragging left a bit more
            else if messageOne.frame.origin.x < -60 && messageOne.frame.origin.x > -260 {
                //clear all secondary icons
                self.listIcon.alpha = 0
                self.archiveIcon.alpha = 0
                self.deleteIcon.alpha = 0
                //change color to yellow
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.messageContainer.backgroundColor = UIColor(red: 255/255, green: 221/255, blue: 77/255, alpha: 1.0)
                    //increase opacity of later icon
                    self.laterIcon.alpha = 1
                    }, completion: nil)
                //move later icon left
                laterIcon.frame.origin.x = messageOne.frame.origin.x + 340
            }
                
            //if dragging left a lot
            else if messageOne.frame.origin.x < -260 {
                self.listIcon.alpha = 1
                self.laterIcon.alpha = 0
                //change color to brown
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.messageContainer.backgroundColor = UIColor(red: 189/255, green: 164/255, blue: 135/255, alpha: 1.0)
                    }, completion: nil)
                //move list icon left
                listIcon.frame.origin.x = messageOne.frame.origin.x + 340
            }
            
            //if dragging right a little
            if messageOne.frame.origin.x > 0 && messageOne.frame.origin.x < 60 {
                //set color to grey
                messageContainer.backgroundColor = UIColor(red: 214/255, green: 214/255, blue: 214/255, alpha: 1.0)
                //set start opacity of archive icon
                archiveIcon.alpha = 0.5
            }
                
            //if dragging right a bit more
            else if messageOne.frame.origin.x > 60 && messageOne.frame.origin.x < 260 {
                //clear all secondary icons
                self.deleteIcon.alpha = 0
                self.laterIcon.alpha = 0
                self.listIcon.alpha = 0
                //change color to green
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.messageContainer.backgroundColor = UIColor(red: 26/255, green: 197/255, blue: 103/255, alpha: 1.0)
                    //increase opacity of archive icon
                    self.archiveIcon.alpha = 1
                    }, completion: nil)
                //move arhive icon right
                archiveIcon.frame.origin.x = messageOne.frame.origin.x - 45
            }
                
            //if dragging right a lot
            else if messageOne.frame.origin.x > 260 {
                self.deleteIcon.alpha = 1
                self.archiveIcon.alpha = 0
                //change color to red
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.messageContainer.backgroundColor = UIColor(red: 248/255, green: 14/255, blue: 93/255, alpha: 1.0)
                    }, completion: nil)
                //move delete icon right
                deleteIcon.frame.origin.x = messageOne.frame.origin.x - 45
            }
        }
            
        else if panGestureRecognizer.state == UIGestureRecognizerState.Ended {
            //do something after pan
            println("Gesture ended at: \(point)")
            
            //if dragged left a little
            if messageOne.frame.origin.x < 0 && messageOne.frame.origin.x > -60 {
                // snap back to position
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.messageOne.frame.origin.x = 0
                })
            }
                
            //if dragged left a bit more
            else if messageOne.frame.origin.x < -60 && messageOne.frame.origin.x > -260 {
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.messageOne.frame.origin.x = -320
                    })
                    { (finished: Bool) -> Void in
                        UIView.animateWithDuration(0.2, animations: { () -> Void in
                            self.reschedulePage.alpha = 1
                            // self.view.addSubview(self.reView)
                        })
                }
            }
                
            //if dragged left a lot
            else if messageOne.frame.origin.x < -260 {
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.messageOne.frame.origin.x = -320
                    })
                    { (finished: Bool) -> Void in
                        UIView.animateWithDuration(0.2, animations: { () -> Void in
                            self.listPage.alpha = 1
                        })
                }
            }
            
            //if dragged right a little
            if messageOne.frame.origin.x > 0 && messageOne.frame.origin.x < 60 {
                // snap back to position
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.messageOne.frame.origin.x = 0
                })
            }
                
            //if dragged right a bit more
            else if messageOne.frame.origin.x > 60 && messageOne.frame.origin.x < 260 {
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.messageOne.frame.origin.x = 320
                    })
                    { (finished: Bool) -> Void in
                        UIView.animateWithDuration(0.2, animations: { () -> Void in
                            self.feedView.frame.origin.y = 80
                        })
                }
            }
                
            //if dragged right a lot
            else if messageOne.frame.origin.x > 260 {
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.messageOne.frame.origin.x = 320
                    })
                    { (finished: Bool) -> Void in
                        UIView.animateWithDuration(0.2, animations: { () -> Void in
                            self.feedView.frame.origin.y = 80
                        })
                }
            }
        }
    }

    //dismissing reschedule page
    @IBAction func ondismissReschedule(sender: AnyObject) {
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.laterIcon.alpha = 0
            self.reschedulePage.alpha = 0
            })
            { (finished: Bool) -> Void in
                //move feed up
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.feedView.frame.origin.y = 80
                })
        }
    }
    
    //dismissing list page
    @IBAction func ondismissList(sender: AnyObject) {
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.listIcon.alpha = 0
            self.listPage.alpha = 0
            })
            { (finished: Bool) -> Void in
                //move feed up
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.feedView.frame.origin.y = 80
                })
        }
    }

    //reset button
    @IBAction func onReset(sender: AnyObject) {
        self.messageOne.frame.origin.x = 0
        self.feedView.frame.origin.y = 166
        //positioning isn't sticking--why??
    }
    
    
    
    
    //to dos
    
    //hidden button to reset all
    //    position of icons on swipe to remove
    //    tri button
    
    
    // click on reschedule to dismiss--alts to hidden button. some ideas:
    //* tap listener established in code for something offscreen!
    //* some action that's not touchUp
    //*if x(true)
    //*a programmatically created view (see guide)
    //ugh, just another view controller. try that. nope, that didn't work. give up--just do hidden button
}
