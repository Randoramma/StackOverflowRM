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
    
    NSMutableArray *jsonData = theData[@"items"];
    for (NSMutableArray *itemArray in jsonData) {
      for (NSDictionary *itemDictionary in itemArray) {
        for (NSDictionary *ownerDictionary in itemDictionary[@"owners"]) {
          NSString *profileImage = ownerDictionary[@"profile_image"];
          NSURL *imageURL = [NSURL URLWithString:profileImage];
          SOQuery *theQuery = [[SOQuery alloc] init];
          [self theImageFromURL:imageURL toSOQuery:theQuery];
          [queries addObject:theQuery];
        } // for loop 3
      } // for loop2
    } // for loop1
  } // if no jsonError
  return queries;
} //parseQueriesFromJSON

+(void)theImageFromURL: (NSURL *)url toSOQuery: (SOQuery*)query{
  
  NSURL *theURL = url;
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
    NSData *imageData = [NSData dataWithContentsOfURL:theURL];
    
    dispatch_async(dispatch_get_main_queue(), ^{
      // Update the UI
      query.myAvatar = [UIImage imageWithData:imageData];
      
    });
  });
} // theImageFromURL
@end
