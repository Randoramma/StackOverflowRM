//
//  StackOverFlowService.m
//  StackOverflowRM
//
//  Created by Randy McLain on 5/12/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import "StackOverFlowService.h"

@implementation StackOverFlowService

+(void)fetchQuestionForSearchTerm:(NSString*)searchTerm completionHandler:(void (^)(NSArray *items, NSString *error))completionHandler {
  
  NSString *url = @"https://api.stackexchange.com/2.2/search?order=desc&sort=activity&intitle=";
  NSString *searchURL = [url stringByAppendingString:searchTerm];
  NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];

  // check if token is available
  if (token){
    searchURL = [searchURL stringByAppendingString:[NSString stringWithFormat:@"&token=%@",token]];
  }
    searchURL = [searchURL stringByAppendingString:[NSString stringWithFormat:@"&site=stackoverflow"]];
  NSLog(@"%@", searchURL);
  [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:searchURL] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    NSLog(@"%@", response); 
  }] resume];

}
@end