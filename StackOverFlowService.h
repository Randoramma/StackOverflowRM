//
//  StackOverFlowService.h
//  StackOverflowRM
//
//  Created by Randy McLain on 5/12/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StackOverFlowService : NSObject

+(void)fetchQuestionForSearchTerm:(NSString*)searchTerm completionHandler:(void (^)(NSArray *items, NSString *error))completionHandler;

@end
