//
//  SearchQuestionsTVC.m
//  StackOverflowRM
//
//  Created by Randy McLain on 5/14/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import "SearchQuestionsTVC.h"
#import "StackOverFlowService.h"
#import "SOQuery.h"

@interface SearchQuestionsTVC () <UISearchBarDelegate, UISearchResultsUpdating>

@property (weak, nonatomic) IBOutlet UITableView *searchTableView;
@property (weak, nonatomic) IBOutlet UITableViewCell *searchTableCell;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) UISearchController *searchController;

@end

@implementation SearchQuestionsTVC

#warning setup a blank array to hold the query objects.
NSArray* queries;

-(void)viewDidLoad {
  self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
  self.searchController.searchResultsUpdater = self;
  self.searchController.dimsBackgroundDuringPresentation = NO;
  self.searchController.searchBar.scopeButtonTitles = @[NSLocalizedString(@"ScopeButtonCountry",@"Country"),
                                                        NSLocalizedString(@"ScopeButtonCapital",@"Capital")];
  self.searchController.searchBar.delegate = self;
  
  self.tableView.tableHeaderView = self.searchController.searchBar;
  self.definesPresentationContext = YES;
  [self.searchController.searchBar sizeToFit];
  
} // viewDidLoad
#pragma - searchBar
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
  [StackOverFlowService fetchQuestionForSearchTerm:searchBar.text completionHandler:^(NSArray *items, NSString *error) {
    int count = 0;
    for (SOQuery *item in items) {
    //[self.tableView cellForRowAtIndexPath:indexPath];
    
    
    
    
    }
    [self.tableView reloadData];
    // reload tableView
  }];
  //
} // searchBarSearchButtonClicked

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope
{
  [self updateSearchResultsForSearchController:self.searchController];
}

#pragma TableView

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"@searchCell" forIndexPath:indexPath];
  
  return cell;
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
  
  
  
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
  NSString *searchString = searchController.searchBar.text;
  
  
//  [self searchForText:searchString scope:searchController.searchBar.selectedScopeButtonIndex];
  [self.tableView reloadData];
} // updateSearchResultsForSearchController

@end
