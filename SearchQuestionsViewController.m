//
//  SearchQuestionsViewController.m
//  StackOverflowRM
//
//  Created by Randy McLain on 5/11/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import "SearchQuestionsViewController.h"
#import "StackOverFlowService.h"

@interface SearchQuestionsViewController () <UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *searchViewTable;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBarSearchView;

@end

@implementation SearchQuestionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  self.searchBarSearchView.delegate = self; 
    // Do any additional setup after loading the view.
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
  [StackOverFlowService fetchQuestionForSearchTerm:searchBar.text completionHandler:^(NSArray *items, NSString *error) {
    
    // take array of query objects and reformat the tableview based on what comes back.
    
    // apply each query to a cell
    
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
