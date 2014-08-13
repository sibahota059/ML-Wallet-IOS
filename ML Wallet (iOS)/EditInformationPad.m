//
//  EditInformationPad.m
//  ML Wallet
//
//  Created by mm20-18 on 8/4/14.
//  Copyright (c) 2014 ML Lhuillier. All rights reserved.
//

#import "EditInformationPad.h"
#import "EditInformationCell.h"
#import "EditAccountInformationPad.h"
#import "EditPasswordPad.h"
#import "EditUsernamePad.h"
#import "EditEmailPad.h"
#import "EditQuestionsPad.h"
#import "EditInformationPadCell.h"


@interface EditInformationPad ()

@end

@implementation EditInformationPad
{
    NSArray *tableData;
}



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
    
    tableData = [NSArray arrayWithObjects:@"Change Account Info", @"Change Password", @"Change Username", @"Change Email", @"Change Secret Questions", nil];
    
    
    [self addNavigationBarButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return [tableData count];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *simpleTableIdentifier = @"EditInformationPadCell";
    
    UIView *accessoryView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 24, 50)];
    UIImageView *accessoryViewImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"disclosureIndicator.png"]];
    [accessoryView addSubview:accessoryViewImage];
    accessoryViewImage.center = CGPointMake(12, 25);
    
    
    
    EditInformationPadCell *cell = (EditInformationPadCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"EditInformationPadCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    
    [cell setAccessoryView:accessoryView];
    cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    return cell;
}









- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    if(indexPath.row == 0)
    {
        
        EditAccountInformationPad *editAccountInformationPad = [[EditAccountInformationPad alloc] initWithNibName:@"EditAccountInformationPad" bundle:nil];
        [self.navigationController pushViewController:editAccountInformationPad animated:YES];
    }
    else if(indexPath.row == 1)
    {
        EditPasswordPad *editPassword = [[EditPasswordPad alloc] initWithNibName:@"EditPasswordPad" bundle:nil];
        [self.navigationController pushViewController:editPassword animated:YES];
    }
    else if(indexPath.row == 2)
    {
        EditUsernamePad *editUsername = [[EditUsernamePad alloc] initWithNibName:@"EditUsernamePad" bundle:nil];
        [self.navigationController pushViewController:editUsername animated:YES];
    }
    else if(indexPath.row == 3)
    {
        EditEmailPad *editEmail = [[EditEmailPad alloc] initWithNibName:@"EditEmailPad" bundle:nil];
        [self.navigationController pushViewController:editEmail animated:YES];
    }
    else
    {
        EditQuestionsPad *editQuestion = [[EditQuestionsPad alloc] initWithNibName:@"EditQuestionsPad" bundle:nil];
        [self.navigationController pushViewController:editQuestion animated:YES];
    }
    
}














-(void) addNavigationBarButton{
    
    self.title = @"Edit Information";
    
    //RIGHT NAVIGATION BUTTON
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 42, 30)];
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 42, 30)];
    //    [backButton setImage:[UIImage imageNamed:@"back_profile.png"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [backView addSubview:backButton];
    
    UIBarButtonItem *backNavButton = [[UIBarButtonItem alloc] initWithCustomView:backView];
    [backNavButton setStyle:UIBarButtonItemStyleBordered];
    
    [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];
    [self.navigationItem setLeftBarButtonItem:backNavButton];
    
}

-(void)backPressed:(id)sender{
    
    [self.navigationController  popViewControllerAnimated:YES];
    
}



- (BOOL)prefersStatusBarHidden{
    return YES;
}


@end
