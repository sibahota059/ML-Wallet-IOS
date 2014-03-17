//
//  MLHistoryViewController.m
//  SendMoney
//
//  Created by mm20 on 3/3/14.
//  Copyright (c) 2014 mm20. All rights reserved.
//

#import "MLHistoryViewController.h"
#import "MLHistoryTableViewCell.h"
#import "MLUI.h"

@interface MLHistoryViewController (){
    NSArray *date, *type, *amount, *balance;
    UIBarButtonItem *back, *right;
    MLUI *getUI;
}

@end

@implementation MLHistoryViewController

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
    getUI = [MLUI new];
    back = [getUI navBarButtonHistory:self navLink:@selector(btn_back:) imageNamed:@"back.png"];
    right = [getUI navBarButtonHistory:self navLink:@selector(btn_sendPreview:) imageNamed:@"home.png"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"view_bg"]];
    
    [self.navigationItem setLeftBarButtonItem:back];
    [self.navigationItem setRightBarButtonItem:right];
    self.navigationItem.titleView = [getUI navTitle:@"History"];
    
    // Do any additional setup after loading the view from its nib.
    date = [NSArray arrayWithObjects:@"January 01, 2014", @"February 01, 2014", @"March 01, 2014", @"April 01, 2014", @"May 01, 2014", @"June 01, 2014", @"July 01, 2014", @"August 01, 2014", @"September 01, 2014", @"October 01, 2014", @"November 01, 2014", @"December 01, 2014", nil];
    
    type = [NSArray arrayWithObjects:@"Sendout", @"Payout", @"Payout", @"Sendout", @"Payout", @"Sendout", @"Payout", @"Sendout", @"Payout", @"Sendout", @"Payout", @"Sendout", nil];
    
    amount = [NSArray arrayWithObjects:@"100.00", @"200.00", @"300.00", @"400.00", @"500.00", @"600.00", @"700.00", @"800.00", @"900.00", @"1000.00", @"1100.00", @"1200.00", nil];
    
    balance = [NSArray arrayWithObjects:@"100.00", @"200.00", @"300.00", @"400.00", @"500.00", @"600.00", @"700.00", @"800.00", @"900.00", @"1000.00", @"1100.00", @"1200.00", nil];
    
    self.viewHistoryHeader.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"navbar_bg.png"]];
}

- (IBAction)btn_back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btn_sendPreview:(id)sender {
    [getUI displayAlert:@"Message" message:@"This will send preview of transaction to email and function it later."];
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
    return [date count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"history";
    
    MLHistoryTableViewCell *cell = (MLHistoryTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil){
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MLHistoryTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.labelDate.text= [date objectAtIndex:indexPath.row];
    cell.labelType.text= [type objectAtIndex:indexPath.row];
    cell.labelAmount.text= [amount objectAtIndex:indexPath.row];
    cell.labelBalance.text= [balance objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@",[date objectAtIndex:indexPath.row]);
    
        
        _view_fade.hidden = NO;
        _view_fade.alpha = 0.2f;
        _view_transform.hidden = NO;
        _labelType.text = [type objectAtIndex:indexPath.row];
        [self shadowView:_view_transform];
        self.navigationItem.rightBarButtonItem.enabled = NO;
        self.navigationItem.leftBarButtonItem.enabled = NO;
}

- (UIView *)shadowView:(UIView*)viewContent{
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:viewContent.bounds];
    viewContent.layer.masksToBounds = NO;
    viewContent.layer.shadowColor = [UIColor blackColor].CGColor;
    viewContent.layer.shadowOffset = CGSizeMake(0.0f, 8.0f);
    viewContent.layer.shadowOpacity = 0.32f;
    viewContent.layer.shadowPath = shadowPath.CGPath;
    
    return viewContent;
}

- (IBAction)btnClose:(id)sender {
    _view_fade.hidden = YES;
    _view_transform.hidden = YES;
    self.navigationItem.rightBarButtonItem.enabled = YES;
    self.navigationItem.leftBarButtonItem.enabled = YES;
}
@end
