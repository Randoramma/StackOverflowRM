//
//  BurgerContainerViewController.m
//  StackOverflowRM
//
//  Created by Randy McLain on 5/11/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import "BurgerContainerViewController.h"
#import "MainMenuTableViewController.h"
#import "MenuSelectionDelegate.h"
#import "MyQuestionsViewController.h"
#import "SearchQuestionsViewController.h"

@interface BurgerContainerViewController () <MenuSelectionDelegate>
@property (strong, nonatomic) UIPanGestureRecognizer *slideGesture;
@property (strong, nonatomic) UITapGestureRecognizer *tapToClose;
@property (strong,nonatomic) UIViewController *topViewController;
@property (strong, nonatomic) UIButton *burgerButton;
@property (strong, nonatomic) MyQuestionsViewController *myQuestionVC;
@property (strong, nonatomic) SearchQuestionsViewController *searchVC;

@end

const int MARGIN_BUFFER = 16;
const int BURGER_SIDE_LENGTH = 50;
const int THIRD_OF_SCREEN = 3;
const float PAN_OPEN_POINT = 0.75;
const float ANIMATION_DURATION = 0.3;
const float FAST_ANIMATION_DURATION = 0.2;


@implementation BurgerContainerViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  MainMenuTableViewController *mainMenuVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MainMenuVC"];
  
  
  // instantiate the MMTableVC.
  [self addChildViewController:mainMenuVC];
  mainMenuVC.view.frame = self.view.frame;
  [self.view addSubview:mainMenuVC.view];
  [mainMenuVC didMoveToParentViewController:self];
  mainMenuVC.myDelegate = self;
  
  // instantiate the 2nd VC.
  self.searchVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchVC"];
  [self addChildViewController:self.searchVC];
  mainMenuVC.view.frame = self.view.frame;
  [self.view addSubview:self.searchVC.view];
  [mainMenuVC didMoveToParentViewController:self];
  self.topViewController = self.searchVC;
  
  // instantiate the slide gesture controller.
  self.slideGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(slidePanelGesture:)];
  [self.topViewController.view addGestureRecognizer:self.slideGesture];
  
  // instantiate the burger button.
  self.burgerButton = [[UIButton alloc] initWithFrame:CGRectMake(MARGIN_BUFFER, MARGIN_BUFFER, BURGER_SIDE_LENGTH, BURGER_SIDE_LENGTH)];
  [self.burgerButton setBackgroundImage:[UIImage imageNamed:@"burger"] forState:UIControlStateNormal];
  [self.burgerButton addTarget:self action:@selector(burgerButtonPressed) forControlEvents:UIControlEventTouchUpInside];
  // add the burger button to the topViewVC.
  [self.topViewController.view addSubview:self.burgerButton];
  // add functionality to close the topViewVC upon clicking the button.
  self.tapToClose = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tappedForClose)];
  
} //viewDidLoad


#pragma mark- Button Methods.
-(void) burgerButtonPressed {
  self.burgerButton.userInteractionEnabled = false;
  [UIView animateWithDuration:ANIMATION_DURATION animations:^{
    // we want the screen to slide over 75% of the screen.
    self.topViewController.view.frame = CGRectMake(self.view.frame.size.width *PAN_OPEN_POINT, 0, self.topViewController.view.frame.size.width, self.topViewController.self.view.frame.size.height);
    
  } completion:^(BOOL finished) {
    // here we are enabling the tapToClose Gesture recognizer.
    [self.topViewController.view addGestureRecognizer:self.tapToClose];
  }];
}

-(void) tappedForClose {
  [self.topViewController.view  removeGestureRecognizer:self.tapToClose];
  [UIView animateWithDuration:ANIMATION_DURATION animations:^{
    self.topViewController.view.center = self.view.center;
  } completion:^(BOOL finished) {
    self.burgerButton.userInteractionEnabled = true;
  }];
}

#pragma mark- Pan Methods.
-(void)slidePanelGesture: (UIPanGestureRecognizer *)pan {
  CGPoint translatedPoint = [pan translationInView:self.view];
  CGPoint velocity = [pan velocityInView:self.view];
  // fires continuosly the user is acting on screen.
  if (pan.state == UIGestureRecognizerStateChanged) {
    if (velocity.x > 0 || self.topViewController.view.frame.origin.x > 0) {
      self.topViewController.view.center = CGPointMake(self.topViewController.view.center.x + translatedPoint.x, self.topViewController.view.center.y);
      [pan setTranslation:CGPointZero inView:self.view];
    } // velocity check
  } // if the user is panning UIGestureRecognizerStateChanged
  if (pan.state == UIGestureRecognizerStateEnded) {
    // if the pan is more than 1/3 the screen.
    if (self.topViewController.view.frame.origin.x > self.view.frame.size.width / THIRD_OF_SCREEN) {
      // disable button
      self.burgerButton.userInteractionEnabled = false;
      // animate the pan just as if the button were clicked.
      [UIView animateWithDuration:ANIMATION_DURATION animations:^{
        self.topViewController.view.frame = CGRectMake(self.view.frame.size.width * PAN_OPEN_POINT, 0, self.topViewController.view.frame.size.width, self.topViewController.view.frame.size.height);
        
        //           self.topViewController.view.center = CGPointMake(, self.topViewController.view.center.y);
      } completion:^(BOOL finished) {
        // enable button to close.
        [self.topViewController.view addGestureRecognizer:self.tapToClose];
      }];
    } else {
      // if the pan is less than 1/3 across the screen.
      [UIView animateWithDuration:FAST_ANIMATION_DURATION animations:^{
        // close the pan.
        self.topViewController.view.center = self.view.center;
      } completion:^(BOOL finished) {
        self.burgerButton.userInteractionEnabled = true;
      }];
    }
  } // UIGestureRecognizerStateEnded
  
} // slidePanelGesture

#pragma mark- Main Menu Navigation Methods.

-(void) userDidSelectOption:(NSInteger)selection {
  switch (selection) {
    case 0:
      if (self.topViewController != self.searchVC) {
        [self switchToViewController:self.searchVC];
        return;
      }
      break;
    case 1:
      if (self.topViewController != self.myQuestionVC) {
        [self switchToViewController:self.myQuestionVC];
        return;
      }
      break;
      
    default:
      break;
  }

} // userDidSelectOption

-(void) switchToViewController: (UIViewController *)destinationVC {
  [UIView animateWithDuration:FAST_ANIMATION_DURATION animations:^{
    
    self.topViewController.view.frame = CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height);
    
  } completion:^(BOOL finished) {
    destinationVC.view.frame = self.topViewController.view.frame;
    
    [self.topViewController.view removeGestureRecognizer:self.slideGesture];
    [self.burgerButton removeFromSuperview];
    [self.topViewController willMoveToParentViewController:nil];
    [self.topViewController.view removeFromSuperview];
    [self.topViewController removeFromParentViewController];
    
    self.topViewController = destinationVC;
    [self addChildViewController:self.topViewController];
    [self.view addSubview:self.topViewController.view];
    [self.topViewController didMoveToParentViewController:self];
    [self.topViewController.view addSubview:self.burgerButton];
    [self.topViewController.view addGestureRecognizer:self.slideGesture];
    
    [UIView animateWithDuration:ANIMATION_DURATION animations:^{
      self.topViewController.view.center = self.view.center;
    } completion:^(BOOL finished) {
      self.burgerButton.userInteractionEnabled = true;
    }];
  }];
} // switchToViewController

#pragma mark- Lazy Loading Methods.
-(MyQuestionsViewController *) myQuestionVC {
  if (_myQuestionVC != nil) {
    return _myQuestionVC;
  } else {
    _myQuestionVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MyQuestionVC"];
    return _myQuestionVC;
  }
}

-(SearchQuestionsViewController *) searchVC {
  if (_searchVC != nil) {
    return _searchVC;
  } else {
    self.searchVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchVC"];
    return _searchVC;
  }
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
} // didReceiveMemoryWarning

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
