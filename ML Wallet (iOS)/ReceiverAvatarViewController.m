//
//  ReceiverAvatarViewController.m
//  ML Wallet
//
//  Created by ml on 2/25/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import "ReceiverAvatarViewController.h"
#import "UIAlertView+alertMe.h"

@interface ReceiverAvatarViewController ()

@end

@implementation ReceiverAvatarViewController
@synthesize nameLabel;
@synthesize addressLabel;
@synthesize relationLabel;
@synthesize imageView;
@synthesize receiver;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self navigator];
    
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

- (void)viewDidUnload
{
    [self setNameLabel:nil];
    [self setAddressLabel:nil];
    [super viewDidUnload];
}
-(void)viewWillAppear:(BOOL)animated
{
    nameLabel.text = receiver.ReceiverName;
    addressLabel.text = receiver.Address;
    relationLabel.text = receiver.Relation;
    imageView.image = receiver.ReceiverImage;
}

#pragma Start #Navigator
- (void)navigator
{
    self.title = @"MY RECEIVER";
    UIBarButtonItem *buttonEdit = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"edit_image.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(EditReceiver)];
    
    UIBarButtonItem *buttonDelete = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(DeleteReceiver)];
    
    NSArray *buttonArray = [[NSArray alloc] initWithObjects:buttonDelete, buttonEdit, nil];
    
    self.navigationItem.rightBarButtonItems = buttonArray;
}


#pragma Start - Selector Delete
- (void)DeleteReceiver
{
    [UIAlertView myCostumeAlert:@"Todo" alertMessage:@"Delete button" delegate:nil cancelButton:@"Cancel" otherButtons:@"YES"];
    //toDO
}


#pragma Start - Selector Edit
- (void)EditReceiver
{
    [UIAlertView myCostumeAlert:@"Todo" alertMessage:@"Edit button" delegate:nil cancelButton:@"Cancel" otherButtons:@"YES"];
    //toDO
}

@end
