//
//  JSONParser.h
//  StackOverflowRM
//
//  Created by Randy McLain on 5/13/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JSONParser : NSObject

+(NSArray *) parseQueriesFromJSON: (NSData *)JSONResponse;




@end
