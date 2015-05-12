//
//  MenuSelectionDelegate.h
//  StackOverflowRM
//
//  Created by Randy McLain on 5/11/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MenuSelectionDelegate <NSObject>

-(void)userDidSelectOption:(NSInteger)selection;

@end
