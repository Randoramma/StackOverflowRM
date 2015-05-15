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
@property (strong, nonatomic) NSMutableArray* queries;

@end

@implementation SearchQuestionsTVC

#warning setup a blank array to hold the query objects.


-(void)viewDidLoad {
  
  self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
  self.searchController.searchResultsUpdater = self;
  self.searchController.dimsBackgroundDuringPresentation = NO;
  self.searchController.searchBar.delegate = self;

  self.tableView.tableHeaderView = self.searchController.searchBar;
  self.definesPresentationContext = YES;
  [self.searchController.searchBar sizeToFit];
//  [self.searchController.searchBar setTranslatesAutoresizingMaskIntoConstraints:false];
//  [self addConstraintToSearchBarControllerView:searchBarContainer withViews: @{@"searchBar" : self.searchController.searchBar}];
  

} // viewDidLoad

-(void)viewDidDisappear:(BOOL)animated {
  

}
#pragma mark - searchBar
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
  [StackOverFlowService fetchQuestionForSearchTerm:searchBar.text completionHandler:^(NSArray *items, NSString *error) {
    int count = 0;
#warning delete this NSLog
    NSLog(@"print Count %d", count);
    for (SOQuery *item in items) {
      [self.queries addObject:item];
      count ++;
    }
    NSLog(@"print Count %d", count);
    #warning delete this NSLog
    [self.tableView reloadData];
    // reload tableView
  }];
  //
} // searchBarSearchButtonClicked

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope
{
  [self updateSearchResultsForSearchController:self.searchController];
}

#pragma mark - TableView
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
//  // Return the number of sections.
//  return 1;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
  // Return the number of rows in the section.
  return self.queries.count;
}

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


- (void) addConstraintToSearchBarControllerView: (UIView *)containerView withViews:(NSDictionary *)views {
NSArray *searchViewHorizontal = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-100-[searchBar]|" options:0 metrics:nil views:views];
//  
//  NSArray *searchViewVertical = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[searchBar]|" options:0 metrics:nil views:views];
  
  [containerView addConstraints:searchViewHorizontal];
//  [containerView addConstraints:searchViewVertical];
}

@end
