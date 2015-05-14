//
//  OauthWebViewController.m
//  StackOverflowRM
//
//  Created by Randy McLain on 5/11/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import "OauthWebViewController.h"
#import "BurgerContainerViewController.h"
#import <WebKit/WebKit.h>

@interface OauthWebViewController () <WKNavigationDelegate>
@property (strong, nonatomic) WKWebView *myWebView;
@property (strong, nonatomic) BurgerContainerViewController *myBurgerView;

@end

@implementation OauthWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  self.myWebView = [[WKWebView alloc] initWithFrame:self.view.frame];
  [self.view addSubview:self.myWebView];
  // become the webview's navigation delegate
  self.myWebView.navigationDelegate = self;
  
  [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://stackexchange.com/oauth/dialog?client_id=4799&scope=no_expiry&redirect_uri=https://stackexchange.com/oauth/login_success"]]];
}

-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
  NSURLRequest *authRequest = navigationAction.request;
  NSURL *theURL = authRequest.URL;
  NSLog(@"%@", theURL);
  decisionHandler(WKNavigationActionPolicyAllow);
  // if the return URL contains the keywords @"access_token" then we have recieved a good key.
  
  
  
  // AFNetworking will replace much of this code VVV // 
  if ([theURL.description containsString:@"access_token"]) {
    // parse up the return string to recieve our key.
    NSArray *theComponents = [[theURL description] componentsSeparatedByString:@"="];
    NSString *theToken = theComponents.lastObject;
#warning Delete this log message.
    NSLog(@"%@",theToken);
    [[NSUserDefaults standardUserDefaults] setObject:theToken forKey:@"token"];
    [[NSUserDefaults standardUserDefaults] synchronize];
 
    [self dismissViewControllerAnimated:true completion:^{

    }];
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
