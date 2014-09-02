//
//  MLViewController.m
//  Registration
//
//  Created by mm20-18 on 3/11/14.
//  Copyright (c) 2014 mm20-18. All rights reserved.
//

#import "MLViewController.h"

@interface MLViewController ()

@end

@implementation MLViewController

@synthesize nextNavButton;
@synthesize nextViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 42, 30)];
        UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 42, 30)];
        [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(backPressed) forControlEvents:UIControlEventTouchUpInside];
        
        [backView addSubview:backButton];
        
        UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithCustomView:backView];
        
        [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];
        [self.navigationItem setLeftBarButtonItem:back];
        

    }
    return self;
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil  viewController:(MLViewController *) viewController
{
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 42, 30)];
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 42, 30)];
    [backButton setImage:[UIImage imageNamed:@"back_profile.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [backView addSubview:backButton];
    
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithCustomView:backView];
    
    
    UIBarButtonItem *next = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStyleBordered target:self action:@selector(nextPressed)];
    
    nextViewController = viewController;

    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];
        [self.navigationItem setRightBarButtonItem:next];
        [self.navigationItem setLeftBarButtonItem:back];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) setNextViewController:(MLViewController *)nextViewControllerParameter myImage:(UIImage *)myImage{

    UIView *questionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 42, 30)];
    UIButton *questionButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 42, 30)];
    [questionButton setImage:myImage forState:UIControlStateNormal];
    [questionButton addTarget:self action:@selector(nextPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [questionView addSubview:questionButton];
    
    UIBarButtonItem *next = [[UIBarButtonItem alloc] initWithCustomView:questionView];
    [next setStyle:UIBarButtonItemStyleBordered];
    
    
    //=================
//    UIBarButtonItem *next = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStyleBordered target:self action:@selector(nextPressed)];
    
    nextViewController = nextViewControllerParameter;
    
    [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];
    [self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationItem setRightBarButtonItem:next];

    
}


-(void) backPressed{
    
    [self.navigationController popViewControllerAnimated:YES];

}


-(void) nextPressed{
    
    [self.navigationController pushViewController:self.nextViewController animated:YES];

}

@end
