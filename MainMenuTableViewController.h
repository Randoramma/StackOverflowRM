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

@property (weak, nonatomic) id<MenuSelectionDelegate> myDelegate;

@end
