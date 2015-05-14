//
//  JSONParser.m
//  StackOverflowRM
//
//  Created by Randy McLain on 5/13/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import "JSONParser.h"
#import "SOQuery.h"
@interface JSONParser ()
@property (weak, nonatomic) NSArray* queries;
@end

@implementation JSONParser

+(NSArray *)parseQueriesFromJSON: (NSData *)JSONResponse {
  
  NSError *jsonError;
  NSMutableArray *queries = [[NSMutableArray alloc] init];
  NSDictionary *theData = [NSJSONSerialization JSONObjectWithData:JSONResponse options:0 error:&jsonError];
  
  if(!jsonError) {
    
    NSMutableArray *dataItems = theData[@"items"];
      for (NSDictionary *anItem in dataItems) {
        SOQuery *theQuery = [[SOQuery alloc] init];
        theQuery.myQuestion = anItem[@"title"];
        NSDictionary *ownerDictionary = anItem[@"owner"];
          NSURL *profileImageURL = ownerDictionary[@"profile_image"];
          [self theImageFromURL:profileImageURL toSOQuery:theQuery];
        
          [queries addObject:theQuery];
    } // for loop1
  } // if no jsonError
  return queries;
} //parseQueriesFromJSON

+(void)theImageFromURL: (NSURL *)url toSOQuery:(SOQuery*)query{
  
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
    NSData *imageData = [[NSData alloc]initWithContentsOfURL:url];
     UIImage *test  = [UIImage imageWithData:imageData];
    
    dispatch_async(dispatch_get_main_queue(), ^{
      // Update the UI
      
    });
  });
} // theImageFromURL
@end
