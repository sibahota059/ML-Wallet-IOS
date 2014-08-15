//
//  MLhuillierWebViewController.m
//  ML Wallet
//
//  Created by ml on 7/26/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import "MLhuillierWebViewController.h"
#import "UIAlertView+alertMe.h"
@interface MLhuillierWebViewController ()

@end

@implementation MLhuillierWebViewController{
    MBProgressHUD *HUD;
    NSInteger *webViewLoads;
}
@synthesize mLhuillierWebView = _mLhuillierWebView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self navigationView];
    webViewLoads=0;
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.delegate = self;
    
    // Do any additional setup after loading the view from its nib.
    NSURL*url=[NSURL URLWithString:@"http://mlhuillier.com"];
    NSURLRequest*request=[NSURLRequest requestWithURL:url];
    [self.mLhuillierWebView loadRequest:request];
    self.mLhuillierWebView.delegate = self;
    self.mLhuillierWebView.scrollView.bounces = NO;
    [self.mLhuillierWebView.scrollView setDelegate:self];
    
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}
#pragma Start #Navigation Items
- (void)navigationView
{
    
    self.navigationController.navigationBarHidden = NO;
    self.title = @"";
    UIBarButtonItem *btnHome = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"home.png"]
                                                                style:UIBarButtonItemStyleBordered
                                                               target:self
                                                               action:@selector(gotoHome)];
    
    UIBarButtonItem *btnBack = [[UIBarButtonItem alloc] initWithTitle:@"Refresh"
                                                                style:UIBarButtonItemStyleBordered
                                                               target:self
                                                               action:@selector(webViewGoBack)];
                                
    self.navigationItem.leftBarButtonItem = btnHome;
    self.navigationItem.rightBarButtonItem = btnBack;
    
    //Set Background
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
}
#pragma Start goto Home View
- (void)gotoHome
{
    [HUD hide:YES];
    [HUD show:NO];
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)webViewGoBack{
    [self.mLhuillierWebView goBack];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - Optional UIWebViewDelegate delegate methods
- (BOOL)mLhuillierWebView:(UIWebView *)mLhuillierWebView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)mLhuillierWebView
{
    webViewLoads++;
    CGFloat width = [[self.mLhuillierWebView stringByEvaluatingJavaScriptFromString:@"document.body.offsetWidth"] floatValue];
    CGRect frame = self.mLhuillierWebView.frame;
    frame.size.width = width;
    self.mLhuillierWebView.frame = frame;
    self.mLhuillierWebView.frame=self.view.bounds;
   // self.navigationItem.leftBarButtonItem.enabled = NO;
   // self.navigationItem.rightBarButtonItem.enabled = NO;
    
    NSLog(@"WebView Loading Started");
    self.mLhuillierWebView.scrollView.contentOffset = CGPointMake(0,120);
    
    HUD.labelText = @"Please wait";
    HUD.square = YES;
    [HUD show:YES];
    [self.view endEditing:YES];
    
    
}

- (void)webViewDidFinishLoad:(UIWebView *)mLhuillierWebView
{
    webViewLoads--;
    NSLog(@"didFinish: %@; stillLoading:%@", [[self.mLhuillierWebView request]URL],
          (self.mLhuillierWebView.loading?@"NO":@"YES"));
    if(webViewLoads==0){
    NSLog(@"Last didFinish: %@; stillLoading:%@", [[self.mLhuillierWebView request]URL],
          (self.mLhuillierWebView.loading?@"NO":@"YES"));
    
  //  self.navigationItem.leftBarButtonItem.enabled = YES;
  //  self.navigationItem.rightBarButtonItem.enabled = YES;
    self.mLhuillierWebView.scrollView.contentOffset = CGPointMake(0,120);
    NSLog(@"WebView Success Loading");
    [HUD hide:YES];
    [HUD show:NO];
    }
    
}

-(void)webView:(UIWebView *)mLhuillierWebView didFailLoadWithError:(NSError *)error{

    NSLog(@"WebView Error : %@",error.localizedDescription);
    webViewLoads--;
    if(webViewLoads==0){
     NSLog(@"Last WebView Error : %@",error.localizedDescription);
        [HUD hide:YES];
        [HUD show:NO];
     //   self.navigationItem.leftBarButtonItem.enabled = YES;
     //   self.navigationItem.rightBarButtonItem.enabled = YES;
        
        [UIAlertView myCostumeAlert:@"Error" alertMessage:[error localizedDescription] delegate:nil cancelButton:@"Ok" otherButtons:nil];
    }

    
}
//detect webview scrolling
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
     //  NSLog(@"scrolled:::");
    if([scrollView isEqual:self.mLhuillierWebView.scrollView]) {
        float webViewScrollPosition = self.mLhuillierWebView.scrollView.contentOffset.y;
        //NSLog(@"Scroll : %f",webViewScrollPosition);
        if(webViewScrollPosition <= 119) {
            [self.mLhuillierWebView.scrollView scrollRectToVisible:CGRectMake(0, self.mLhuillierWebView.bounds.size.height + 120, 1, 1) animated:NO];
        }
        
    }
}

@end