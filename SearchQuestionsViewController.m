//
//  SearchQuestionsViewController.m
//  StackOverflowRM
//
//  Created by Randy McLain on 5/11/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import "SearchQuestionsViewController.h"
#import "StackOverFlowService.h"
#import "SOQuery.h"

@interface SearchQuestionsViewController () <UISearchBarDelegate, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *searchViewTable;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBarSearchView;

@end

@implementation SearchQuestionsViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.searchBarSearchView.delegate = self;
  self.searchViewTable.delegate = self;
#warning setup a blank array to hold the query objects.
  NSArray* queries;
  
  
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
  [StackOverFlowService fetchQuestionForSearchTerm:searchBar.text completionHandler:^(NSArray *items, NSString *error) {
    
    NSLog(@"%lu", (unsigned long)items.count);
//    if (!error) {
//      for (theItem in items) {
//        
//        
//        
//      }
//    }
    // take array of query objects and reformat the tableview based on what comes back.
    
    // apply each query to a cell
    [self.searchViewTable reloadData];
    // reload tableView
  }];
  //
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
