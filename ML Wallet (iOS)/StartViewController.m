//
//  StartViewController.m
//  Account
//
//  Created by mm20-18 on 2/20/14.
//  Copyright (c) 2014 mm20-18. All rights reserved.
//

#import "StartViewController.h"
#import "QuestionVerificationDialog.h"
#import "SelectQuestionDialog.h"
#import "AccountMain.h"
#import "UpdateInformation.h"

@interface StartViewController ()

@end

@implementation StartViewController


SelectQuestionDialog *dialog;
UITextField *selectedQuestion;


NSArray *questions1;

UIScrollView *profileScroll;

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
    // Do any additional setup after loading the view from its nib.

      [self addNavigationBarButton];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma  mark - NAVIGATION
-(void)bckButtonClicked:(id) sender{
    
    AccountMain *mAccount = [[AccountMain alloc] initWithNibName:@"AccountMain" bundle:nil];
    
    [self.navigationController pushViewController:mAccount animated:YES ];
}


-(void) addNavigationBarButton{

    UIBarButtonItem *myNavButton = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStyleBordered target:self action:@selector(bckButtonClicked:)];
    
    [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];
    [self.navigationItem setRightBarButtonItem:myNavButton];
}

@end
