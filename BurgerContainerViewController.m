//
//  BurgerContainerViewController.m
//  StackOverflowRM
//
//  Created by Randy McLain on 5/11/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import "BurgerContainerViewController.h"
#import "MainMenuTableViewController.h"
#import "SearchQuestionsViewController.h"

@interface BurgerContainerViewController ()
@property (strong, nonatomic) UIPanGestureRecognizer *slideGesture;
@property (strong,nonatomic) UIViewController *topViewController;


@end

@implementation BurgerContainerViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  MainMenuTableViewController *mainMenuVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MainMenuVC"];
  
  [self addChildViewController:mainMenuVC];
  mainMenuVC.view.frame = self.view.frame;
  [self.view addSubview:mainMenuVC.view];
  [mainMenuVC didMoveToParentViewController:self];
  
  SearchQuestionsViewController *searchVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchVC"];
  [self addChildViewController:searchVC];
  mainMenuVC.view.frame = self.view.frame;
  [self.view addSubview:searchVC.view];
  [mainMenuVC didMoveToParentViewController:self];
  self.topViewController = searchVC;
  
  self.slideGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(slidePanelGesture:)];
  
  [self.topViewController.view addGestureRecognizer:self.slideGesture];
  
} //viewDidLoad


-(void)slidePanelGesture: (UIPanGestureRecognizer *)pan {
  CGPoint translatedPoint = [pan translationInView:self.view];
  CGPoint velocity = [pan velocityInView:self.view];
  // fires continuosly the user is acting on screen.
  if (pan.state == UIGestureRecognizerStateChanged) {
    if (velocity.x > 0 || self.topViewController.view.frame.origin.x > 0) {
      self.topViewController.view.center = CGPointMake(self.topViewController.view.center.x + translatedPoint.x, self.topViewController.view.center.y);
      [pan setTranslation:CGPointZero inView:self.view];
    }
  }
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
