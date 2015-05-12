//
//  MainMenuTableViewController.h
//  StackOverflowRM
//
//  Created by Randy McLain on 5/11/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuSelectionDelegate.h"

@interface MainMenuTableViewController : UITableViewController

// weak assignment to the delegate property.  "The delegator should never own the delegate."
@property (weak, nonatomic) id<MenuSelectionDelegate> myDelegate;

@end
