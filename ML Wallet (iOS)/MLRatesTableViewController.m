//
//  MLRatesTableViewController.m
//  SendMoney
//
//  Created by mm20 on 2/17/14.
//  Copyright (c) 2014 mm20. All rights reserved.
//

#import "MLRatesTableViewController.h"
#import "MLUI.h"
#import "MLRatesTableViewCell.h"

@interface MLRatesTableViewController (){

    NSArray *amount, *rates;

}
@end

@implementation MLRatesTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    MLUI *getUI = [MLUI new];
    self.navigationItem.titleView = [getUI navTitle:@"MLKP Rates"];

    amount = [NSArray arrayWithObjects:@"0.01 - 100.00", @"100.01 - 200.00", @"200.01 - 300.00", @"300.01 - 400.00", @"400.01 - 500.00", @"500.01 - 600.00", @"600.01 - 800.00", @"800.01 - 900.00", @"900.01 - 1,000.00", @"1,000.01 - 1,500.00", @"1,500.01 - 2,000.00", @"2,000.01 - 2,500.00", @"2,500.01 - 3,000.00", @"3,000.01 - 4,000.00", @"4,000.01 - 9,500.00", @"9,500.01 - 14,000.00", @"14,000.01 - 30,000.00", @"30,000.01 - 40,000.00", @"40,000.01 - 50,000.00", nil];
    rates = [NSArray arrayWithObjects:@"7.00", @"13.00", @"18.00", @"25.00", @"30.00", @"35.00", @"40.00", @"45.00", @"50.00", @"80.00", @"100.00", @"130.00", @"150.00", @"180.00", @"220.00", @"240.00", @"300.00", @"350.00", @"400.00", nil];
    
    [self swipe];
}

-(void)swipe{
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(left)];
    
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRight];
}

- (void)left{
    self.tabBarController.selectedIndex = 0;
    [self.navigationController.tabBarController.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [amount count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"rates";
    
    MLRatesTableViewCell *cell = (MLRatesTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil){
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MLRatesTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.labelAmount.text = [amount objectAtIndex:indexPath.row];
    cell.labelRates.text= [rates objectAtIndex:indexPath.row];
    return cell;
}


@end
