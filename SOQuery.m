//
//  SOQuery.m
//  StackOverflowRM
//
//  Created by Randy McLain on 5/13/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import "SOQuery.h"

@implementation SOQuery


// ==========================
// = Designated initializer =
// ==========================

-(id)initWithQuestionAndAvatar: (NSString *)question date:(UIImage *)avatar
{
  if (self = [super init])
  {
    [self setMyQuestion:question];
    [self setMyAvatar:avatar];
  }
  return self;
}
@end
