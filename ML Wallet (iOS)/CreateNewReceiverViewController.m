//
//  CreateNewReceiverViewController.m
//  ML Wallet
//
//  Created by ml on 2/21/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import "CreateNewReceiverViewController.h"
#import "UIAlertView+alertMe.h"

@interface CreateNewReceiverViewController ()

@end

@implementation CreateNewReceiverViewController

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
    
    //Set Navigator
    [self navigator];
    [self.MyScrollview setScrollEnabled:YES];
    [self.MyScrollview setContentSize:CGSizeMake(320, 600)];
    
    //Set Background
    if ([UIScreen mainScreen].bounds.size.height >= 568) //4 inch
    {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"MLBackground1.png"]]];
    }
    else //4 inc below
    {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"MLBackground3.png"]]];
    }
}


#pragma Start #Navigator
- (void)navigator
{
    self.title = @"NEW RECEIVER";
    UIBarButtonItem *buttonAddReceiver = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"save.png"] style:UIBarButtonItemStyleDone  target:self action:@selector(saveReceiver)];
    self.navigationItem.rightBarButtonItem = buttonAddReceiver;
}

#pragma Start #Save New Receiver
- (void)saveReceiver
{
    if ([self ifAllInputed]) {
        [UIAlertView myCostumeAlert:@"Save" alertMessage:@"To be added" delegate:nil cancelButton:nil otherButtons:@"Ok"];
    }
}


#pragma Start #Verify input fields
- (BOOL) ifAllInputed
{
    if (([self.txtFirstName.text length] && [self.txtLastName.text length] && [self.txtAddress.text length]) <= 0) {
        [UIAlertView myCostumeAlert: @"Validation Error" alertMessage:@"Input all valid fields" delegate:nil cancelButton:nil otherButtons:@"OK"];
        return FALSE;
    }
    else
    {
        return TRUE;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
